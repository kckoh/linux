import glob
import pandas as pd

# Get a list of all CSV files in the current directory
csv_files = glob.glob("./docs/*.csv")

# Create an empty list to store the dataframes
df_list = []

# Loop through the CSV files and read each one into a dataframe
for file in csv_files:
    df = pd.read_csv(file)
    df_list.append(df)


# Concatenate the dataframes into a single dataframe
combined_df = pd.concat(df_list)
combined_df = combined_df.loc[:, 'Longitude (x)':'Time (LST)']

# Write the combined dataframe to a new CSV file
combined_df.to_csv("./docs/all_years.csv", index=False)
