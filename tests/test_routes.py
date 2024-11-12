# Unit tests for your Flask routes 

"""
ranch_data = [('PapuRancho', 'tumami', 2), ('JuanRancho', '999.999', 2) ]
ranch_data = []


for i in range(0,len(ranch_data)):
    print(ranch_data[i][0])
    print(ranch_data[i][1])

    if len(ranch_data) < 3 and i == len(ranch_data) -1 :
        print("add ranch")

if not ranch_data:
    print("add ranch")


"""
#Jsonify
columns = ["a","b","c"]
rows = [(1, 'Alice', 25), (2, 'Bob', 30)]


result = [dict(zip(columns,row)) for row in rows]


for row in rows:
    print(row)


    
print()

print(result)

