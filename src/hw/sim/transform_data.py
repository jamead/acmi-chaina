# Read the file and process the data
with open("data.txt", "r") as infile:
    data = infile.read().split()  # Split by any whitespace (spaces, tabs, newlines)

# Write the formatted output to a new file
with open("formatted_data.txt", "w") as outfile:
    for entry in data:
        outfile.write(entry + "\n")

print("Data reformatted and saved to formatted_data.txt")

