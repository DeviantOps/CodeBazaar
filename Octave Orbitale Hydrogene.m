% Paramètres
Z = 1; % Numéro atomique de l'hydrogène
n = 3; % Nombre quantique principal
l = 1; % Nombre quantique azimutal
hbar = 1; % Constante réduite de Planck
m = 1; % Masse de l'électron

% Définition de la fonction d'onde radiale
function y = R(r)
    y = r.^l * exp(-Z*r/n/hbar) * laguerre(n-l-1, 2*l+1, 2*Z*r/n/hbar);
endfunction

% Définition de l'équation radiale
function y = radial_eq(r)
    y = -1/2/m * (l*(l+1)/r^2 + 2*Z/r - 2*Z^2/hbar^2) * R(r);
endfunction

% Résolution numérique
r_values = linspace(0.01, 10, 1000);
psi = zeros(size(r_values));

for i = 1:length(r_values)
    psi(i) = radial_eq(r_values(i));
end

% Tracé du résultat
plot(r_values, psi);
xlabel('Rayon (a.u.)');
ylabel('Fonction d\'onde radiale');
title('Équation de Schrödinger radiale pour l\'hydrogène');

