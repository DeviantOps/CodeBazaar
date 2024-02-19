const d3 = require('d3');

const dataset = [1, 2, 3, 4, 5];

const sum = d3.sum(dataset);
console.log('Somme des données :', sum);

const scale = d3.scaleLinear()
  .domain([0, d3.max(dataset)])
  .range([0, 100]);

console.log('Valeur échelonnée :', scale(3));
