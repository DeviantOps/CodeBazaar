% Charger la séquence à partir du fichier
sequence_file = 'sequenced.lst';
sequence = fileread(sequence_file);

% Supprimer les espaces, sauts de ligne, etc.
sequence = regexprep(sequence, '\s', '');

% Déterminer la longueur de la séquence
sequence_length = length(sequence);
disp(['Longueur de la séquence : ' num2str(sequence_length)]);

% Diviser la séquence en codons de taille 3
codon_size = 3;
num_codons = floor(sequence_length / codon_size);

codons = reshape(sequence(1:num_codons*codon_size), codon_size, num_codons)';

% Afficher les codons
disp('Codons dans la séquence :');
disp(codons);

% Exemple d'analyse des codons (à adapter selon les besoins)
disp('Analyse des codons :');
for i = 1:num_codons
    current_codon = codons(i, :);
   
    % Ajouter ici le code d'analyse/détection pour chaque codon
   
    % Exemple : Afficher le numéro du codon et sa séquence
    disp(['Codon ' num2str(i) ': ' current_codon]);
end
