% Load data from file

data = csvread('b.csv', 1, 0);

 

% Standardize data

data = zscore(data);

 

% Apply k-means clustering

num_clusters = 3;

[cluster_labels, centroids] = kmeans(data, num_clusters);

 

% Plot cluster assignments

figure;

scatter(data(:,1), data(:,2), [], cluster_labels);

xlabel('Feature 1');

ylabel('Feature 2');

title(['k-means clustering with ' num2str(num_clusters) ' clusters']);

 

% Print centroid coordinates

disp('Cluster centroids:');

disp(centroids);
