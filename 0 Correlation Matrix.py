import pandas as pd

 

# Load data from file

df = pd.read_csv('b.csv')

 

# Calculate correlation matrix

corr_matrix = df.corr()

 

# Print correlation matrix

print(corr_matrix)
