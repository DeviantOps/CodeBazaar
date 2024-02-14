import csv

 

# Create dictionary to map unique strings to unique integers

string_to_int = {}

next_int = 1

 

with open('a.csv', newline='') as csvfile:

    reader = csv.reader(csvfile, delimiter=',')

    header = next(reader) # get header row

    rows = []

    for row in reader:

        int_row = []

        for element in row:

            if element.isdigit():

                int_element = int(element)

                int_row.append(int_element)

            elif element in string_to_int:

                int_element = string_to_int[element]

                int_row.append(int_element)

            else:

                int_element = next_int

                string_to_int[element] = int_element

                int_row.append(int_element)

                next_int += 1

        rows.append(int_row)

 

# Write output file

with open('b.csv', 'w', newline='') as csvfile:

    writer = csv.writer(csvfile, delimiter=',')

    writer.writerow(header) # write header row

    for row in rows:

        writer.writerow(row)
