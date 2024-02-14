import pandas as pd

from sklearn.cluster import KMeans

 

# Load data from file

df = pd.read_csv('b.csv')

 

# Apply KMeans algorithm

kmeans = KMeans(n_clusters=3, random_state=0).fit(df)

 

# Add cluster labels to dataframe

df['Cluster'] = kmeans.labels_

 

# Save updated dataframe to file

df.to_csv('c.csv', index=False)

 
