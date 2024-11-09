# Unit tests for your Flask routes 

ranch_data = [('PapuRancho', 'tumami', 2), ('JuanRancho', '999.999', 2) , ('JuanRancho', '999.999', 2) ]


for i in range(0,len(ranch_data)):
    print(ranch_data[i][0])
    print(ranch_data[i][1])

    if len(ranch_data) < 3 and i == len(ranch_data) -1 :
        print("add ranch")
    