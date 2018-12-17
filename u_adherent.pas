UNIT u_adherent;
INTERFACE
	CONST
		Cmax = 100;
		
	TYPE
	
		Tadresse = record
			rue : string;
			numeroRue : string;
			npa : string;
			ville : string;
			pays : string;
		END;
		
		Tadherent = record
		    codeAdherent : string;
			nom : string;
			prenom : string;
			adresse : Tadresse;
		END;	
		
		TypeTabAdherents = ARRAY[0..Cmax-1] OF Tadherent;
		
		// Demande toutes les informations à l'utilisateur et retourne un nouveau adherent ayant les informations saisies
		FUNCTION saisirAdherent():Tadherent;
		// Affiche toutes les informations de l'adherent
		PROCEDURE afficherAdherent(adherent:Tadherent);
		
IMPLEMENTATION
	
	FUNCTION saisirAdherent():Tadherent;
	VAR
		a : Tadherent;
	BEGIN
		writeln('Code adherent : ');
		readln(a.codeAdherent);
		writeln('Nom : ');
		readln(a.nom);
		writeln('Prenom : ');
		readln(a.prenom);
		writeln('Adresse : ');
	END;
	
	
	PROCEDURE afficherAdherent(adherent:Tadherent);
	BEGIN
		
	END;

END.
