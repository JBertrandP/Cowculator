# Unit tests for database interactions 
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from backend import db_methods



ranch_data = [{'FarmID': 1013, 'FarmName': 'LolRancho', 'Location': 'Cuu', 'OwnerID': 1009, 'FarmImage': '','TotalCows':0}, {'FarmID': 1014, 'FarmName': 'FokRancho', 'Location': '111', 'OwnerID': 1009, 'FarmImage': '' ,'TotalCows':50}]

"""
print(ranch_data)
for i,ranch in enumerate(ranch_data):
    
    
    print ( ranch.get('FarmName') ) 
    print(ranch.get('Location'))

    

"""
for ranch in ranch_data:
    
    if ranch['TotalCows'] !=  0:
        print(ranch['TotalCows'])



