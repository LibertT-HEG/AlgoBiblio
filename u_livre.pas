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
		
	END;

	FUNCTION saisirLivre(): Tlivre;
	BEGIN
		
	END;
	

	
	PROCEDURE afficherLivre(livre:Tlivre);
	BEGIN
		
	END;
	
	FUNCTION creerEmprunt(livre:Tlivre; adherent:Tadherent; date:Tdate):Temprunt;
	BEGIN
		
	END;
	
	PROCEDURE afficherEmprunt(emprunt:Temprunt);
	BEGIN
		
	END;
	
	PROCEDURE ajouterExemplaire(var livre:Tlivre);
	BEGIN
		
	END;
	
	FUNCTION supprimerExemplaire(var livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION estDisponible(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts:INTEGER):BOOLEAN; 
	BEGIN
		
	END;
	
	FUNCTION compteExemplairesDisponibles(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER; // Retourne le nombre d'exemplaires encore disponibles		
	BEGIN
		
	END;
	
	FUNCTION compteExemplairesEmpruntes(livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):INTEGER;
	BEGIN
		
	END;
	
	FUNCTION compteEmpruntsParAdherent(tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER; adherent : Tadherent) : INTEGER;
	BEGIN
		
	END;
	
END.
