PROGRAM p_biblio;
USES u_biblio, u_livre, u_adherent, crt;

	PROCEDURE initProgram();
	BEGIN
		u_livre.initUnite();
	END;
	
	//Procedure chargeant déjà quelques données de base
	PROCEDURE chargeDonneesInitiales(var biblio:Tbibliotheque; var adherent: Tadherent; var livre: Tlivre);
	BEGIN

	
		biblio.nomBiblio:='Arc Biblio';
		biblio.adresse.rue:='Espace de l''Europe';
		biblio.adresse.numeroRue:='21';
		biblio.adresse.npa:='2000';
		biblio.adresse.ville:='Neuchatel';	
		biblio.adresse.pays:='Suisse';
	
	
		//TODO : à compléter avec quelques adhérents et quelques livres
		
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

	// Attribut(s) d'un adherent :
	codeAdherent: STRING;

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
			
			ClrScr;
			CASE choix OF 
				1 : BEGIN
						
					END;
				2 : BEGIN
						
					END;
				3 : BEGIN
						
					END;
				4 : BEGIN
						
					END;
				5 : BEGIN
						
					END;
				6 : BEGIN
						
					END;
				7 : BEGIN
						
					END;
				8 : BEGIN
						
					END;
				9 : BEGIN
						
					END;
				10 : BEGIN
						
					END;
				11 : BEGIN
						
					END;
				12 : BEGIN
						
					END;
				13 : BEGIN
						
					END;
				14 : BEGIN
						
					END;
				0 : BEGIN
						
					END;
			END;
			
		END
	UNTIL (choix = 0);
END.
