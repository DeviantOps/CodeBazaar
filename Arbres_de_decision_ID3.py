import math

from collections import Counter

 

def entropy(labels):

    n_labels = len(labels)

    if n_labels <= 1:

        return 0

    counts = Counter(labels).values()

    probs = [count / n_labels for count in counts]

    return - sum([prob * math.log(prob, 2) for prob in probs])

 

def information_gain(data, split_attribute_name, target_attribute_name):

    total_entropy = entropy(data[target_attribute_name])

    n = len(data)

    split_counts = Counter(data[split_attribute_name])

    split_entropy = sum([(split_counts[label] / n) * entropy(data.where(data[split_attribute_name] == label).dropna()[target_attribute_name]) for label in split_counts])

    information_gain = total_entropy - split_entropy

    return information_gain

 

def id3(data, original_data, features, target_attribute_name, parent_node_class=None):

    if len(data) == 0:

        return Counter(original_data[target_attribute_name]).most_common(1)[0][0]

    elif len(set(data[target_attribute_name])) <= 1:

        return data[target_attribute_name].iloc[0]

    elif len(features) == 0:

        return parent_node_class

    else:

        parent_node_class = Counter(data[target_attribute_name]).most_common(1)[0][0]

        item_values = [information_gain(data, feature, target_attribute_name) for feature in features]

        best_feature_index = item_values.index(max(item_values))

        best_feature = features[best_feature_index]

        tree = {best_feature: {}}

        features = [i for i in features if i != best_feature]

        for value in set(data[best_feature]):

            sub_data = data.where(data[best_feature] == value).dropna()

            subtree = id3(sub_data, original_data, features, target_attribute_name, parent_node_class)

            tree[best_feature][value] = subtree

        return tree
