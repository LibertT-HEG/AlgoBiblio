UNIT u_adherent;
INTERFACE
	CONST
		Cmax = 100;
		
	TYPE
	
		Tadresse = RECORD
			rue : STRING;
			numeroRue : String;
			npa : String;
			ville : STRING;
			pays : STRING;
		END;
		
		Tadherent = RECORD
		    codeAdherent : STRING;
			nom : STRING;
			prenom : STRING;
			adresse : Tadresse;
		END;	
		
		TypeTabAdherents = ARRAY[0..Cmax-1] OF Tadherent;
		
		// Demande toutes les informations à l'utilisateur et retourne un nouveau adherent ayant les informations saisies
		FUNCTION saisirAdherent():Tadherent;
		// Affiche toutes les informations de l'adherent
		PROCEDURE afficherAdherent(adherent:Tadherent);
		
IMPLEMENTATION
	
	FUNCTION saisirAdherent():Tadherent;
	BEGIN
		
	END;
	
	
	PROCEDURE afficherAdherent(adherent:Tadherent);
	BEGIN
		
	END;

END.
