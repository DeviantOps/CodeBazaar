% Load data from file

data = csvread('b.csv', 1, 0);

 

% Standardize data

data = zscore(data);

 

% Apply PCA

[coeff, score, latent] = pca(data);

 

% Plot principal components

figure;

scatter(score(:,1), score(:,2));

xlabel('PC1');

ylabel('PC2');

title('PCA');

 

% Print explained variance ratio

explained_var = 100 * latent / sum(latent);

disp(['Explained variance ratio: ' num2str(explained_var(1)) '%, ' num2str(explained_var(2)) '%']);

 
