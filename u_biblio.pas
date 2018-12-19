UNIT u_biblio;
INTERFACE
	USES u_livre, u_adherent;
	
	CONST
		Cmax = 100;
		
	TYPE
	
		Tbibliotheque = RECORD
			nomBiblio : STRING;
			tabLivres : TypeTabLivres;
			nbLivres : INTEGER;
			tabEmprunts : TypeTabEmprunts;
			nbEmprunts : INTEGER;
			tabAdherents : TypeTabAdherents;
			nbAdherents : INTEGER;
			adresse : Tadresse;
		END;
	
	// Initialise les attributs de la bibliothèque
	PROCEDURE initBiblio(var biblio:Tbibliotheque);
	// Affiche l'ensemble des informations de la bibliothèque
	PROCEDURE afficherBibliotheque(biblio:Tbibliotheque);
	// Permet de savoir si la bibliothèque est ouverte ou non ! Elle est ouverte du mardi au samedi de 8h à 12h et de 14h à 20h, et le lundi de 14h à 18h !
	FUNCTION estOuverte(jour:String; heure:INTEGER):BOOLEAN;
	
	// Ajoute un nouveau livre à la bibliothèque
	FUNCTION ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; nouveauLivre : Tlivre) : BOOLEAN; 
	// Supprime le livre de la bibliothèque, à condition qu'il ne soit plus emprunté !
	FUNCTION supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	// Cherche le livre dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau.
	FUNCTION trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : INTEGER; livre:Tlivre; var indiceRetour:INTEGER):BOOLEAN;
	// Cherche dans la bibliothèque le livre qui correspond à l'ISBN passé en paramètre
	FUNCTION trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : INTEGER; isbn:STRING; var livre:Tlivre):BOOLEAN;
	// Cherche dans la bibliothèque tous les livres qui contiennent le code d'auteur passé en paramètre
	FUNCTION trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : INTEGER; codeAuteur:STRING; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:INTEGER):BOOLEAN;
	
	// Ajoute un nouvel adhérent à la bibliothèque
	FUNCTION ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent) : BOOLEAN;
	// Supprime de la bibliothèque l'adhérent passé en paramètre, à condition que celui-ci n'est plus d'emprunt à son code !
	FUNCTION supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	// Cherche l'adhérent dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau.
	FUNCTION trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; var indiceRetour : INTEGER) : BOOLEAN;
	// Cherche dans la bibliothèque l'adhérent qui correspond au code passé en paramètre.
	FUNCTION trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; codeAdherent:STRING; var adherentTrouve:Tadherent) : BOOLEAN;
	
	// Crée un emprunt avec les informations passées en paramètres et l'ajoute à la liste des emprunts de la bibliothèque
	FUNCTION emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):BOOLEAN;
	// Supprime l'emprunt de la liste des emprunts de la bibliothèque
	FUNCTION rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; emprunt:Temprunt):BOOLEAN;
	// Cherche l'emprunt dans la bibliothèque et, s'il est trouvé, retourne sa position dans le tableau
	FUNCTION trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:INTEGER; emprunt:Temprunt; var indiceRetour : INTEGER):BOOLEAN; 
	// Cherche dans la bibliothèque l'emprunt qui correspond au numéro passé en paramètre
	FUNCTION trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; var emprunt:Temprunt ;numero:INTEGER):BOOLEAN;
	
IMPLEMENTATION
	// PHILIPPE
	PROCEDURE initBiblio(var biblio:Tbibliotheque);
	BEGIN
		biblio.nomBiblio := '';
		biblio.nbLivres := 0;
		biblio.nbEmprunts := 0;
		biblio.nbAdherents := 0;
	END;

	// Affiche un message sous forme de titre entouré d'une séquence de caractères sur chaque côté
	// deja repetée dans deux fichiers différents faudra surement l'isoler dans un module à part
	PROCEDURE afficherTitre(titre:string; sequence: string; repetition:integer);
	VAR
		ind : integer;
		decoration : string;
	BEGIN
		decoration := '';
		FOR ind := 0 TO repetition DO
		BEGIN
			decoration := decoration + sequence;
		END;
		Writeln(decoration, ' ', titre, ' ', decoration);
	END;
	
	PROCEDURE afficherBibliotheque(biblio:Tbibliotheque);
	VAR
		ind : integer;
	BEGIN
		// nom de la bibliotheque
		afficherTitre(biblio.nomBiblio, '=', 10);

		Writeln(biblio.adresse.rue, ' ', biblio.adresse.numeroRue, ', ', biblio.adresse.npa, ' ', biblio.adresse.ville, ' (', biblio.adresse.pays, ')');
		Writeln(LineEnding, 'Liste des livres de la bibliotheque : ');
		// lister les livres
		for ind := 0 to biblio.nbLivres - 1 do
		begin
			Writeln('ISBN : ', biblio.tabLivres[ind].isbn, ' Titre : ', biblio.tabLivres[ind].titre, ' Code d''auteur : ', biblio.tabLivres[ind].codeAuteur, ' Nombre de pages : ', biblio.tabLivres[ind].nbPages, ' Exemplaires : ', biblio.tabLivres[ind].nbExemplaires);
		end;
		Writeln(LineEnding, 'Liste des adherents de la bibliotheque : ');
		for ind := 0 to biblio.nbAdherents - 1 do
		begin
			writeln(biblio.tabAdherents[ind].prenom, ' ', biblio.tabAdherents[ind].nom, ' (', biblio.tabAdherents[ind].codeAdherent, ') ');
			writeln(biblio.tabAdherents[ind].adresse.rue, ' ', biblio.tabAdherents[ind].adresse.numeroRue, ', ', biblio.tabAdherents[ind].adresse.npa, ' ', biblio.tabAdherents[ind].adresse.ville, ' (', biblio.tabAdherents[ind].adresse.pays, ')');
		end;
		Writeln(LineEnding, 'Liste des emprunts en cours : ');
		for ind := 0 to biblio.nbEmprunts - 1 do
		begin
			Writeln('Numero : ', biblio.tabEmprunts[ind].numeroEmprunt, ' Livre : ', biblio.tabEmprunts[ind].livre.titre, ' (', biblio.tabEmprunts[ind].livre.isbn, '). Adherent : ', biblio.tabEmprunts[ind].adherent.prenom, ' ', biblio.tabEmprunts[ind].adherent.nom, ' (', biblio.tabEmprunts[ind].adherent.codeAdherent, ') le ', biblio.tabEmprunts[ind].dateEmprunt.jour, '.', biblio.tabEmprunts[ind].dateEmprunt.mois, '.', biblio.tabEmprunts[ind].dateEmprunt.annee, '.');
		end;
	END;
	
	// Permet de savoir si la bibliothèque est ouverte ou non ! Elle est ouverte du mardi au samedi de 8h à 12h et de 14h à 20h, et le lundi de 14h à 18h !
	FUNCTION estOuverte(jour:String; heure:INTEGER):BOOLEAN;
	BEGIN
		estOuverte := false;

		IF jour <> 'dimanche' THEN
		BEGIN
			IF jour <> 'lundi' THEN // du mardi au samedi
				IF ((heure >= 8) AND (heure < 12)) OR ((heure > 14) AND (heure < 20)) THEN
					estOuverte := true
			ELSE //si on est lundi
				IF (heure >= 14) AND (heure < 18) THEN
					estOuverte := true
		END;
	END;
	
	FUNCTION ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; nouveauLivre : Tlivre) : BOOLEAN; 
	BEGIN
		ajouterNouveauLivre := FALSE;
		IF nbLivres < u_livre.Cmax THEN
		BEGIN
			tabLivres[nbLivres] := nouveauLivre;
			nbLivres := nbLivres + 1;
			ajouterNouveauLivre := TRUE;
		END;
	END;
	
	FUNCTION supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	VAR
		ind : integer;
		indiceLivre : integer;
	BEGIN
		supprimerLivre := false;
		indiceLivre := -1;
		if not(u_livre.compteExemplairesEmpruntes(livre, tabEmprunt, nbEmprunts) > 0) then
			if trouverIndiceLivre(tabLivres, nbLivres, livre, indiceLivre) then
			BEGIN
			IF nbLivres > (indiceLivre + 1) THEN
				FOR ind := indiceLivre TO nbLivres - 2 DO
					tabLivres[ind] := tabLivres[ind + 1];
			nbLivres := nbLivres - 1;
		END;
	END;

	FUNCTION trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : INTEGER; livre:Tlivre; var indiceRetour:INTEGER):BOOLEAN;
	VAR
		ind : integer;
	BEGIN
		trouverIndiceLivre := false;
		for ind := 0 to nbLivres - 1 do
			if tabLivres[ind].isbn = livre.isbn then
			begin
				indiceRetour := ind;
				trouverIndiceLivre := true;
			end;
	END;
	
	FUNCTION trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : INTEGER; isbn:STRING; var livre:Tlivre):BOOLEAN;
	VAR
		ind : integer;
	BEGIN
		trouverLivreParISBN := false;
		for ind := 0 to nbLivres do
			if tabLivres[ind].isbn = isbn then
			begin
				livre := tabLivres[ind];
				trouverLivreParISBN := true;
			end;
	END;
	
	FUNCTION trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : INTEGER; codeAuteur:STRING; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:INTEGER):BOOLEAN;
	VAR
		ind : integer;
	BEGIN
		trouverLivresParAuteur := false;
		for ind := 0 to nbLivres do
			if tabLivres[ind].codeAuteur = codeAuteur then
			begin
				tabLivresTrouves[nbLivresTrouves] := tabLivres[ind];
				nbLivresTrouves := nbLivresTrouves + 1;
				trouverLivresParAuteur := true;
			end;
	END;
	//ADRIEN
	FUNCTION ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent) : BOOLEAN;
	BEGIN
		ajouterNouvelAdherent := false;
		if(nbAdherents<Cmax) THEN
		begin
			tabAdherents[nbAdherents] := adherent;
			nbAdherents := nbAdherents+1;
			ajouterNouvelAdherent := true;
		end;
	END;
	
	FUNCTION supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	VAR
		ind : integer;
		indiceAdherent : integer;
	BEGIN
		supprimerAdherent := false;
		IF((compteEmpruntsParAdherent(tabEmprunt,nbEmprunts,adherent) = 0)) AND (trouverIndiceAdherent(tabAdherents, nbAdherents, adherent, indiceAdherent)) then
		begin
			if not(indiceAdherent+1 = nbAdherents) then
			begin
				for ind := indiceAdherent to nbAdherents - 2 do
					tabAdherents[ind] := tabAdherents[ind + 1];
			end;
			nbAdherents := nbAdherents - 1;
			supprimerAdherent := true;
		end;
	END;
	
	FUNCTION trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; var indiceRetour : INTEGER) : BOOLEAN;
	VAR
		ind : integer;
	BEGIN
		trouverIndiceAdherent := false;
		for ind := 0 to nbAdherents - 1 do
			if tabAdherents[ind].codeAdherent = adherent.codeAdherent then
			begin
				indiceRetour := ind;
				trouverIndiceAdherent := true;
			end;
	END;
	
	FUNCTION trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; codeAdherent:STRING; var adherentTrouve:Tadherent) : BOOLEAN;
	VAR
		ind : integer;
	BEGIN
		trouverAdherentParCode := false;
		for ind := 0 to nbAdherents - 1 do
			if tabAdherents[ind].codeAdherent = codeAdherent then
			begin
				adherentTrouve := tabAdherents[ind];
				trouverAdherentParCode := true;
			end;
	END;
	// THIBAULT
	FUNCTION emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):BOOLEAN;
	BEGIN
		IF u_livre.estDisponible(livre, tabEmprunts, nbEmprunts) THEN
		BEGIN		
			tabEmprunts[nbEmprunts] := u_livre.creerEmprunt(livre, adherent, dateEmprunt);
			nbEmprunts := nbEmprunts + 1;
			emprunterLivre := true;
		END
		ELSE
			emprunterLivre := false;
	END;
	
	FUNCTION rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; emprunt:Temprunt):BOOLEAN; 
	VAR
		ind : INTEGER;
		indiceEmprunt : INTEGER;
		livreValide : BOOLEAN;
	BEGIN
		livreValide := trouverIndiceEmprunt(tabEmprunts, nbEmprunts, emprunt, indiceEmprunt);
		IF livreValide THEN
		BEGIN
			IF nbEmprunts > (indiceEmprunt + 1) THEN
				FOR ind := indiceEmprunt TO nbEmprunts - 2 DO
					tabEmprunts[ind] := tabEmprunts[ind + 1];
			nbEmprunts := nbEmprunts - 1;
		END;
		rendreLivre := livreValide;
	END;
	
	FUNCTION trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:INTEGER; emprunt:Temprunt; var indiceRetour : INTEGER):BOOLEAN; 
	VAR
		ind : INTEGER;
		trouve : BOOLEAN;
	BEGIN
		trouve := false;
		ind := 0;
		WHILE ( (NOT trouve) AND (ind < nbEmprunts) ) DO
		BEGIN
			IF tabEmprunts[ind].numeroEmprunt = emprunt.numeroEmprunt THEN
			BEGIN
				trouve := true;
				indiceRetour := ind;
			END;
			ind := ind + 1;
		END;
		trouverIndiceEmprunt := trouve;
	END;
	
	FUNCTION trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; var emprunt:Temprunt ;numero:INTEGER):BOOLEAN;
	VAR
		ind : INTEGER;
		trouve : BOOLEAN;
	BEGIN
		trouve := false;
		ind := 0;
		WHILE ( (NOT trouve) AND (ind < nbEmprunts) ) DO
		BEGIN
			IF tabEmprunts[ind].numeroEmprunt = numero THEN
			BEGIN
				trouve := true;
				emprunt := tabEmprunts[ind];
			END;
			ind := ind + 1;
		END;
		trouverEmpruntParNumero := trouve;
	END;
END.