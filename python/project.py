import csv
import ast
import os

file = open("keywords.csv", encoding="utf8")
csvreader = csv.reader(file)
header = next(csvreader)

f1 = open("Keyword1.csv", 'w', newline='', encoding="utf8")
writer1 = csv.writer(f1)
header1 = ['id', 'name']
writer1.writerow(header1)

f2 = open("hasKeyword.csv", 'w', newline='', encoding="utf8")
writer2 = csv.writer(f2)
header2 = ['movie_id', 'keyword_id']
writer2.writerow(header2)

for row in csvreader:
    data = ast.literal_eval(row[1])
    for i in range(len(data)):
        writer1.writerow([data[i]['id'], data[i]['name']])
        writer2.writerow([row[0], data[i]['id']])

f2.close()
f1.close()
file.close()

f1 = open("Keyword1.csv", 'r', encoding="utf8")
csvreader = csv.reader(f1)

f3 = open('Keyword.csv', 'w', newline='', encoding="utf8") 
writer3 = csv.writer(f3)

seen = set() 
for row in csvreader:
    if row[0] and row[1] in seen:
        continue
    seen.add(row[0])
    seen.add(row[1])
    writer3.writerow(row)

f3.close()
f1.close()

os.remove('Keyword1.csv')