Clustering (K-means) :


import random

 

def k_means_clustering(points, k, max_iterations=100):

    centroids = random.sample(points, k)

    for i in range(max_iterations):

        clusters = [[] for _ in range(k)]

        for point in points:

            distances = [euclidean_distance(point, centroid) for centroid in centroids]

            nearest_centroid = distances.index(min(distances))

            clusters[nearest_centroid].append(point)

        new_centroids = [list(map(lambda x: sum(x) / len(x), zip(*cluster))) for cluster in clusters]

        if centroids == new_centroids:

            break

        centroids = new_centroids

    return clusters
