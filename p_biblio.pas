PROGRAM p_biblio;
USES u_biblio, u_livre, u_adherent, crt, dos, sysutils;

	PROCEDURE initProgram();
	BEGIN
		u_livre.initUnite();
	END;

	PROCEDURE printTitre(titre : STRING);
	VAR
		longueur : integer;
		ligneHautBas : string;
		ligneTitre : string;
		ind : integer;
	BEGIN
		longueur := Length(titre);
		ligneHautBas := '+';
		FOR ind := 0 TO longueur+1 DO
		BEGIN
			ligneHautBas := ligneHautBas + '-';
		END;
		ligneHautBas := ligneHautBas + '+';
		ligneTitre := '| ' + titre + ' |';
		writeln(ligneHautBas + LineEnding + ligneTitre + LineEnding + ligneHautBas);
	END;
	
	//Procédure chargeant déjà quelques données de base
	PROCEDURE chargeDonneesInitiales(var biblio:Tbibliotheque; var adherent: Tadherent; var livre: Tlivre);
	BEGIN	
		biblio.nomBiblio:='Arc Biblio';
		biblio.adresse.rue:='Espace de l''Europe';
		biblio.adresse.numeroRue:='21';
		biblio.adresse.npa:='2000';
		biblio.adresse.ville:='Neuchatel';	
		biblio.adresse.pays:='Suisse';

		//TODO : A compléter avec quelques adhérents et quelques livres
		livre.isbn := '978-2-02-130452-7';
		livre.titre := 'George et ses copains';
		livre.codeAuteur := '4B1TB0L';
		livre.nbPages := 123;
		livre.nbExemplaires := 1;

		biblio.tabLivres[biblio.nbLivres] := livre;
		biblio.nbLivres := biblio.nbLivres + 1;

		livre.isbn := '142-2-12-330252-7';
		livre.titre := 'Vendre des marchandises';
		livre.codeAuteur := 'T4R1K0';
		livre.nbPages := 14;
		livre.nbExemplaires := 4;

		biblio.tabLivres[biblio.nbLivres] := livre;
		biblio.nbLivres := biblio.nbLivres + 1;

		livre.isbn := '645-6-52-331802-1';
		livre.titre := 'Martine euthanasie Medor';
		livre.codeAuteur := 'M4RT1N';
		livre.nbPages := 34;
		livre.nbExemplaires := 2;

		biblio.tabLivres[biblio.nbLivres] := livre;
		biblio.nbLivres := biblio.nbLivres + 1;

		livre.isbn := '645-6-52-331802-2';
		livre.titre := 'L''histoire de Pascal du debut a la fin';
		livre.codeAuteur := 'P4SC4L';
		livre.nbPages := 22;
		livre.nbExemplaires := 12;

		biblio.tabLivres[biblio.nbLivres] := livre;
		biblio.nbLivres := biblio.nbLivres + 1;

		adherent.codeAdherent := 'DAVE';
		adherent.prenom := 'Dave';
		adherent.nom := 'Quantic';
		adherent.adresse.rue := 'Place du Telephone';
		adherent.adresse.numeroRue := '11';
		adherent.adresse.npa := '1224';
		adherent.adresse.ville := 'San Francisco';
		adherent.adresse.pays := 'Etats-Unis';

		biblio.tabAdherents[biblio.nbAdherents] := adherent;
		biblio.nbAdherents := biblio.nbAdherents + 1;

		adherent.codeAdherent := 'CLASSE';
		adherent.prenom := 'George';
		adherent.nom := 'Abitbol';
		adherent.adresse.rue := 'Rue de la Classe';
		adherent.adresse.numeroRue := '1';
		adherent.adresse.npa := '321400';
		adherent.adresse.ville := 'Bateau';
		adherent.adresse.pays := 'Atoll de Pom Pom Galli';

		biblio.tabAdherents[biblio.nbAdherents] := adherent;
		biblio.nbAdherents := biblio.nbAdherents + 1;

		adherent.codeAdherent := 'COQUET';
		adherent.prenom := 'Jose';
		adherent.nom := 'Denomme';
		adherent.adresse.rue := 'Rue de la Coquetterie';
		adherent.adresse.numeroRue := '100';
		adherent.adresse.npa := '321400';
		adherent.adresse.ville := 'Bateau';
		adherent.adresse.pays := 'Atoll de Pom Pom Galli';

		biblio.tabAdherents[biblio.nbAdherents] := adherent;
		biblio.nbAdherents := biblio.nbAdherents + 1;
	END;

VAR
	biblio : Tbibliotheque;
	choix : INTEGER;
	adherent : Tadherent;
	livre : Tlivre;
	date : Tdate;
	numEmprunt : INTEGER;
	emprunt : Temprunt;
	continuer : STRING;
	heureOuvert : INTEGER;
	jourOuvert : STRING;
	indiceLivre : INTEGER;
	
	// Attribut(s) d'un livre :
	isbn:STRING;

	// Attribut(s) d'un adhérent :
	codeAdherent: STRING;

	// Variable booléenne pour effectuer des tests
	trouve : BOOLEAN;

	// Variable word inutile pour les appels sur la date système
	dummyWord : WORD;

BEGIN
	initProgram(); // Va initialiser la variable globale compteurEmprunt a 0
	u_biblio.initBiblio(biblio);

	chargeDonneesInitiales(biblio, adherent, livre);
	
	REPEAT
		BEGIN
			WRITELN('Que souhaitez-vous faire ?');
			WRITELN('1. Emprunter un livre');
			WRITELN('2. Rendre un livre');
			WRITELN('3. Verifier la disponibilite d''un livre');
			WRITELN('4. Ajouter un livre a la bibliotheque');
			WRITELN('5. Ajouter un exemplaire d''un livre');
			WRITELN('6. Ajouter un nouvel adherent');
			WRITELN('7. Recherche et affichage de livre(s)');
			WRITELN('8. Recherche et affichage d''emprunt');
			WRITELN('9. Recherche et affichage d''adherent');
			WRITELN('10. Supprimer un exemplaire d''un livre');
			WRITELN('11. Supprimer un livre');
			WRITELN('12. Supprimer un adherent');
			WRITELN('13. Verifier si la bibliotheque est ouverte');
			WRITELN('14. Afficher toutes les informations de la bibliotheque');
			WRITELN('0. Quitter l''application');
			REPEAT
				READLN(choix);
			UNTIL (choix >= 0) AND (choix <= 14);
			
			ClrScr; // clear screen (empeche de scroller et voir les données trop longues)
			CASE choix OF 
				1 : BEGIN
						printTitre('Emprunter un livre');
						
						REPEAT
							WRITE('Saisissez le code de l''adherent : ');
							READLN(codeAdherent);
							trouve := u_biblio.trouverAdherentParCode(
								biblio.tabAdherents,
								biblio.nbAdherents,
								codeAdherent,
								adherent);
							IF NOT trouve THEN
								WRITELN('Le code saisi ne correspond a aucun adherent. Reessayez.');
						UNTIL trouve;
						
						REPEAT
							WRITE('Saisissez l''ISBN du livre a emprunter : ');
							READLN(isbn);
							trouve := u_biblio.trouverLivreParISBN(
								biblio.tabLivres,
								biblio.nbLivres,
								isbn,
								livre
							);
							IF NOT trouve THEN
								WRITELN('L''ISBN saisi n''existe pas dans la bibliotheque. Reessayez.');
						UNTIL trouve;

						GetDate(Word(date.annee), Word(date.mois), Word(date.jour), dummyWord);

						IF u_biblio.emprunterLivre(
							biblio.tabEmprunts,
							biblio.nbEmprunts,
							livre,
							adherent, 
							date
						) THEN
							WRITELN('L''emprunt du livre "', livre.titre, '" a ete fait avec succes.')
						ELSE
							WRITELN('Ce livre n''est pas disponible.');
					END;
				2 : BEGIN
						printTitre('Rendre un livre');

						REPEAT
							WRITE('Saisissez le numero d''emprunt du livre : ');
							READLN(numEmprunt);
							trouve := u_biblio.trouverEmpruntParNumero(
								biblio.tabEmprunts,
								biblio.nbEmprunts,
								emprunt,
								numEmprunt
							);
							IF NOT trouve THEN
								WRITELN('Ce numero d''emprunt ne correspond pas a un emprunt de la bibliotheque. Reessayez.');
						UNTIL trouve;

						IF u_biblio.rendreLivre(
							biblio.tabEmprunts,
							biblio.nbEmprunts,
							emprunt
						) THEN
							WRITELN('Le livre "', emprunt.livre.titre, '" a bien ete rendu.')
						ELSE
							WRITELN('Un probleme est survenu dans le rendu du livre.');
					END;
				3 : BEGIN
						printTitre('Verifier la disponibilite d''un livre');
						
						REPEAT
							WRITE('Saisissez l''ISBN du livre : ');
							READLN(isbn);
							trouve := u_biblio.trouverLivreParISBN(
								biblio.tabLivres,
								biblio.nbLivres,
								isbn,
								livre
							);
							IF NOT trouve THEN
								WRITELN('L''ISBN saisi n''existe pas dans la bibliotheque. Reessayez.');
						UNTIL trouve;

						IF u_livre.estDisponible(
							livre,
							biblio.tabEmprunts,
							biblio.nbEmprunts
						) THEN
							WRITELN('Le livre "', livre.titre, '" est disponible.')
						ELSE
							WRITELN('Le livre "', livre.titre, '" n''est pas disponible.');
					END;
				4 : BEGIN						
						printTitre('Ajouter un livre a la bibliotheque');	

						livre := u_livre.saisirLivre();
						IF NOT u_biblio.trouverLivreParISBN(
							biblio.tabLivres,
							biblio.nbLivres,
							livre.isbn,
							livre
						) THEN
						BEGIN
							IF u_biblio.ajouterNouveauLivre(
								biblio.tabLivres,
								biblio.nbLivres,
								livre
							) THEN
								WRITELN('Le livre "', livre.titre, '" a ete ajoute a la bibliotheque.')
							ELSE
								WRITELN('Un probleme est survenu dans l''ajout du livre.');
						END;
					END;
				5 : BEGIN
						printTitre('Ajouter un exemplaire d''un livre');

						REPEAT
							WRITE('Saisissez l''ISBN du livre a ajouter : ');
							READLN(isbn);
							trouve := u_biblio.trouverLivreParISBN(
								biblio.tabLivres,
								biblio.nbLivres,
								isbn,
								livre
							);
							IF NOT trouve THEN
								WRITELN('L''ISBN saisi n''existe pas dans la bibliotheque. Reessayez.');
						UNTIL trouve;
						u_biblio.trouverIndiceLivre(biblio.tabLivres, biblio.nbLivres, livre, indiceLivre);
						u_livre.ajouterExemplaire(biblio.tabLivres[indiceLivre]);
					END;
				6 : BEGIN
						printTitre('Ajouter un nouvel adherent');

						adherent := u_adherent.saisirAdherent();
						// TODO: peut-etre faire un check si tout a bien fonctionne
						// Tout doux...
						u_biblio.ajouterNouvelAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent);

					END;
				7 : BEGIN
						printTitre('Recherche et affichage de livre(s)');

						REPEAT
							WRITE('Saisissez l''ISBN du livre a rechercher : ');
							READLN(isbn);
							trouve := u_biblio.trouverLivreParISBN(
								biblio.tabLivres,
								biblio.nbLivres,
								isbn,
								livre
							);
							IF NOT trouve THEN
								WRITELN('L''ISBN saisi n''existe pas dans la bibliotheque. Reessayez.');
						UNTIL trouve;

						u_livre.afficherLivre(livre);
					END;
				8 : BEGIN
						printTitre('Recherche et affichage d''emprunt');

						REPEAT
							WRITE('Saisissez le numero d''emprunt a rechercher : ');
							READLN(numEmprunt);
							trouve := u_biblio.trouverEmpruntParNumero(
								biblio.tabEmprunts,
								biblio.nbEmprunts,
								emprunt,
								numEmprunt
							);
							IF NOT trouve THEN
								WRITELN('Ce numero d''emprunt ne correspond pas a un emprunt de la bibliotheque. Reessayez.');
						UNTIL trouve;

						u_livre.afficherEmprunt(emprunt);
					END;
				9 : BEGIN
						printTitre('Recherche et affichage d''adherent');

						WRITELN('Saisir code adherent :');
						READLN(codeAdherent);
						if(u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents, codeAdherent, adherent)) then
							u_adherent.afficherAdherent(adherent)
						else
							WRITELN('Erreur. Le code adherent saisi n''existe pas.');
					END;
				10 : BEGIN
						printTitre('Supprimer un exemplaire d''un livre');

						WRITELN('Saisir ISBN livre :');
						READLN(isbn);
						if(u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre)) then
							if u_livre.supprimerExemplaire(livre, biblio.tabEmprunts, biblio.nbEmprunts) then
								WRITELN('Exemplaire supprime.')
							else
								WRITELN('Impossible de supprimer un exemplaire de ce livre. Aucun exemplaire disponible ou existant')
						else
							WRITELN('Erreur. L''ISBN saisi n''existe pas.');
					END;
				11 : BEGIN
						printTitre('Supprimer un livre');

						WRITELN('Saisir ISBN livre :');
						READLN(isbn);
						if(u_biblio.trouverLivreParISBN(biblio.tabLivres, biblio.nbLivres, isbn, livre)) then
							if u_biblio.supprimerLivre(biblio.tabLivres, biblio.nbLivres, livre, biblio.tabEmprunts, biblio.nbEmprunts) then
								WRITELN('Livre supprime.')
							else
								WRITELN('Impossible de supprimer ce livre. Il se peut que des exemplaires soient actuellement empruntes.')
						else
							WRITELN('Erreur. L''ISBN saisi n''existe pas.');
					END;
				12 : BEGIN
						printTitre('Supprimer un adherent');
						
						WRITELN('Saisir code adherent :');
						READLN(codeAdherent);
						if(u_biblio.trouverAdherentParCode(biblio.tabAdherents, biblio.nbAdherents, codeAdherent, adherent)) then
							if u_biblio.supprimerAdherent(biblio.tabAdherents, biblio.nbAdherents, adherent, biblio.tabEmprunts, biblio.nbEmprunts) then
								WRITELN('Adherent supprime.')
							else
								WRITELN('Impossible de supprimer cet adherent. Il se peut que des livres soient actuellement empruntes par cet adherent.')
						else
							WRITELN('Erreur. Le code adherent saisi n''existe pas.');
					END;
				13 : BEGIN
						printTitre('Verifier si la bibliotheque est ouverte');
						repeat
							WRITELN('Saisir jour (Lundi, Mardi, ...)');
							READLN(jourOuvert);
						until ((LowerCase(jourOuvert) = 'lundi') OR (LowerCase(jourOuvert) = 'mardi') OR (LowerCase(jourOuvert) = 'mercredi') OR (LowerCase(jourOuvert) = 'jeudi') OR (LowerCase(jourOuvert) = 'vendredi') OR (LowerCase(jourOuvert) = 'samedi') OR (LowerCase(jourOuvert) = 'dimanche'));
						repeat
							WRITELN('Saisir Heure (9, 12, 13, ...)');
							READLN(heureOuvert);
						until ((heureOuvert >= 0) AND (heureOuvert <= 23));
						if(u_biblio.estOuverte(jourOuvert,heureOuvert)) then
							WRITELN('La bibliotheque est ouverte.')
						else
							WRITELN('La bibliotheque est fermee ou la saisie est incorrecte.');
					END;
				14 : BEGIN
						printTitre('Afficher toutes les informations de la bibliotheque');
						
						u_biblio.afficherBibliotheque(biblio);
					END;
				0 : BEGIN
						
					END;
			END;
			
		END
	UNTIL (choix = 0);
END.