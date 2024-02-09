import math

 

def euclidean_distance(p1, p2):

    return math.sqrt(sum([(p1[i] - p2[i])**2 for i in range(len(p1))]))

 

def k_nearest_neighbors(train, test, k):

    distances = [(euclidean_distance(test, train[i][:-1]), i) for i in range(len(train))]

    sorted_distances = sorted(distances)

    neighbors = [train[sorted_distances[i][1]] for i in range(k)]

    return max(set(neighbors), key = neighbors.count)[-1]
