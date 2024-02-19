const fs = require('fs');

// Lire le contenu d'un fichier
fs.readFile('fichier.txt', 'utf8', (err, data) => {
  if (err) throw err;
  console.log(data);
});

// Écrire dans un fichier
fs.writeFile('fichier.txt', 'Contenu du fichier', (err) => {
  if (err) throw err;
  console.log('Le fichier a été écrit avec succès.');
});
