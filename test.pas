PROGRAM test;
USES u_adherent, u_livre, u_biblio;
VAR
    dummyAdherent : Tadherent;
    dummyLivre : Tlivre;
BEGIN
    dummyAdherent.codeAdherent := 'A7578afSFwe';
    dummyAdherent.prenom := 'Philippe';
    dummyAdherent.nom := 'Oswald';
    dummyAdherent.adresse.rue := 'Temple';
    dummyAdherent.adresse.numeroRue := '37';
    dummyAdherent.adresse.npa := '2024';
    dummyAdherent.adresse.ville := 'St-Aubin';
    dummyAdherent.adresse.pays := 'Suisse';

    dummyLivre.isbn := '473f34z389475fh';
    dummyLivre.titre := 'George et ses copains';
    dummyLivre.codeAuteur := '4B1780L';
    dummyLivre.nbPages := 885;
    dummyLivre.nbExemplaires := 1;

    Writeln(LineEnding, 'Test de la procedure u_adherent.afficherAdherent : ');
    afficherAdherent(dummyAdherent);

    Writeln(LineEnding, 'Test de la procedure u_livre.afficherLivre : ');
    afficherLivre(dummyLivre);
    Writeln(LineEnding, 'Test de la fonction u_biblio.estOuverte : ');
    IF estOuverte('samedi', 12) THEN
        writeln('La bibliotheque est ouverte')
    ELSE
        writeln('La bibliotheque est fermee');


END.