UNIT u_livre;
INTERFACE
	USES u_adherent;
	
	CONST
		Cmax = 100;
	VAR
		// Variable globale qui doit être initialisée à 0 au début du programme et incrémentée de 1 à chaque création d'emprunt !
		compteurEmprunt : INTEGER;
	TYPE
	
		Tlivre = RECORD
			isbn : STRING;
			titre : STRING;
			codeAuteur : STRING;
			nbPages : INTEGER;
			nbExemplaires : INTEGER; // Par exemple, la bibliothèque peut posséder trois exemplaires du petit larousse illustré 2013
		END;
		
		TypeTabLivres = ARRAY[0..Cmax-1] OF Tlivre;
		
		Tdate = RECORD
			jour : INTEGER;
			mois : INTEGER;
			annee : INTEGER;
		END;
	
		Temprunt = RECORD
			numeroEmprunt : INTEGER; //Incrémenté selon le compteur global "compteurEmprunt" déclaré ci-dessous.
			livre : Tlivre;
			adherent : Tadherent;
			dateEmprunt : Tdate;
		END;
		
		TypeTabEmprunts = ARRAY[0..Cmax-1] OF Temprunt;
		
		// Initialise l'unité, en mettant le compteur d'emprunts à 0
		PROCEDURE initUnite();
		// Demande toutes les informations à l'utilisateur et retourne un nouveau livre ayant les informations saisies
		FUNCTION saisirLivre():Tlivre;
		// Affiche toutes les informations du livre
		PROCEDURE afficherLivre(livre:Tlivre);
		// Retourne un nouvel emprunt contenant les informations passées en paramètres et un numéro unique (grâce à compteurEmprunt)
		FUNCTION creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
		// Affiche les informations principales de l'emprunt
		PROCEDURE afficherEmprunt(emprunt:Temprunt);
		
		// Ajoute un exemplaire supplémentaire au livre passé en paramètre
		PROCEDURE ajouterExemplaire(var livre:Tlivre);
		// Supprime un exemplaire au livre passé en paramètre, à condition qu'il reste un moins un exemplaire du livre qui ne soit pas déjà emprunté !
		FUNCTION supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN;
		// Vérifie s'il reste au moins un exemplaire du livre qui n'est pas emprunté
		FUNCTION estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN; 
		// Compte le nombre d'exemplaires du livre qui ne sont pas empruntés et retourne le total
		FUNCTION compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER;
		// Compte le nombre d'exemplaires du livre qui sont empruntés et retourne le total
		FUNCTION compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER;
		// Compte le nombre d'emprunts qui sont au code de l'adhérent et retourne le total
		FUNCTION compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER; adherent : Tadherent) : INTEGER;
		
IMPLEMENTATION
	PROCEDURE initUnite();
	BEGIN
		compteurEmprunt := 0;
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

	END;

	FUNCTION saisirLivre(): Tlivre;
	VAR
		livre : Tlivre;
	BEGIN
		write('ISBN : ');
		readln(livre.isbn);
		write('Titre : ');
		readln(livre.titre);
		write('Code de l''auteur : ');
		readln(livre.codeAuteur); // Test existe ?
		write('Nombre de pages : ');
		readln(livre.nbPages); // Test si c'est un nombre
		write('Nombre d''exemplaires : ');
		readln(livre.nbExemplaires); // Test si c'est un nombre

		saisirLivre := livre;
	END;
	
	PROCEDURE afficherLivre(livre:Tlivre);
	BEGIN
		afficherTitre(livre.titre, '=', 10);
		writeln('ISBN : ', livre.isbn);
		writeln('Code auteur : ', livre.codeAuteur);
		writeln('Nombre de pages : ', livre.nbPages);
		writeln('Nombre d''exemplaires : ', livre.nbExemplaires);
		
	END;
	
	FUNCTION creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
	BEGIN
		compteurEmprunt := compteurEmprunt+1; // On ajoute un emprunt à notre compteur
		creerEmprunt.numeroEmprunt := compteurEmprunt;
		creerEmprunt.livre := livre;
		creerEmprunt.dateEmprunt := date;
	END;
	
	PROCEDURE afficherEmprunt(emprunt:Temprunt);
	BEGIN
		writeln('Numéro de l''emprunt : ', emprunt.numeroEmprunt);
		writeln('Livre emprunté :');
		writeln('- ISBN : ', emprunt.livre.isbn);
		writeln('- Code auteur : ', emprunt.livre.codeAuteur);
		writeln('- Nombre de pages : ', emprunt.livre.nbPages);
		writeln('- Nombre d''exemplaires : ', emprunt.livre.nbExemplaires);
		writeln('Emprunté par : ', emprunt.adherent.prenom, ' ', emprunt.adherent.nom);
		writeln('Emprunté le : ', emprunt.date.jour,'.',emprunt.date.mois,'.',emprunt.date.annee);

	END;
	
	PROCEDURE ajouterExemplaire(var livre:Tlivre);
	BEGIN
		
	END;
	
	FUNCTION supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER;
	VAR
		nbEmpruntsLivre : INTEGER;
		ind : INTEGER;
	BEGIN
		nbEmpruntsLivre := 0;
		FOR ind := 0 TO nbEmprunts - 1 DO
		BEGIN
			IF tabEmprunt[ind].livre.isbn = livre.isbn THEN
				nbEmpruntsLivre := nbEmpruntsLivre + 1;
		END;
		compteEmpruntsParAdherent := nbEmpruntsLivre;
	END;

	FUNCTION compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER; // Retourne le nombre d'exemplaires encore disponibles	
	VAR
		nbEmpruntsLivre : INTEGER;
	BEGIN
		nbEmpruntsLivre := compteExemplairesEmpruntes(livre, tabEmprunt, nbEmprunts);
		compteExemplairesDisponibles := livre.nbExemplaires - nbEmpruntsLivre;
	END;

	FUNCTION estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN; 
	BEGIN
		estDisponible := compteExemplairesDisponibles(livre, tabEmprunt, nbEmprunts) > 0;
	END;
	
	FUNCTION compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER; adherent : Tadherent) : INTEGER;
	VAR
		nbEmpruntsAdherent : INTEGER;
		ind : INTEGER;
	BEGIN
		nbEmpruntsAdherent := 0;
		FOR ind := 0 TO nbEmprunts - 1 DO
		BEGIN
			IF tabEmprunt[ind].adherent.codeAdherent = adherent.codeAdherent THEN
				nbEmpruntsAdherent := nbEmpruntsAdherent + 1;
		END;
		compteEmpruntsParAdherent := nbEmpruntsAdherent;
	END;

	
END.
