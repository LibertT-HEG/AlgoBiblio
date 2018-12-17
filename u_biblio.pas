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

	PROCEDURE initBiblio(var biblio:Tbibliotheque);
	BEGIN
		
	END;
	
	PROCEDURE afficherBibliotheque(biblio:Tbibliotheque);
	BEGIN
		
	END;
	
	FUNCTION estOuverte(jour:String; heure:INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION ajouterNouveauLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; nouveauLivre : Tlivre) : BOOLEAN; 
	BEGIN
		
	END;
	
	FUNCTION supprimerLivre(var tabLivres : TypeTabLivres; var nbLivres : INTEGER; livre:Tlivre; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION trouverIndiceLivre(tabLivres : TypeTabLivres; nbLivres : INTEGER; livre:Tlivre; var indiceRetour:INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION trouverLivreParISBN(tabLivres : TypeTabLivres; nbLivres : INTEGER; isbn:STRING; var livre:Tlivre):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION trouverLivresParAuteur(tabLivres : TypeTabLivres; nbLivres : INTEGER; codeAuteur:STRING; var tabLivresTrouves:TypeTabLivres; var nbLivresTrouves:INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION ajouterNouvelAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent) : BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION supprimerAdherent(var tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; tabEmprunt:TypeTabEmprunts; nbEmprunts : INTEGER):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION trouverIndiceAdherent(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; adherent:Tadherent; var indiceRetour : INTEGER) : BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION trouverAdherentParCode(tabAdherents:TypeTabAdherents; var nbAdherents:INTEGER; codeAdherent:STRING; var adherentTrouve:Tadherent) : BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION emprunterLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; livre:Tlivre; adherent:Tadherent;dateEmprunt:Tdate):BOOLEAN;
	BEGIN
		
	END;
	
	FUNCTION rendreLivre(var tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; emprunt:Temprunt):BOOLEAN; 
	BEGIN
		
	END;
	
	FUNCTION trouverIndiceEmprunt(tabEmprunts:TypeTabEmprunts; nbEmprunts:INTEGER; emprunt:Temprunt; var indiceRetour : INTEGER):BOOLEAN; 
	BEGIN
		
	END;
	
	FUNCTION trouverEmpruntParNumero(tabEmprunts:TypeTabEmprunts; var nbEmprunts:INTEGER; var emprunt:Temprunt ;numero:INTEGER):BOOLEAN;
	BEGIN
		
	END;
END.
