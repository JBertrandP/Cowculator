#we import the neccessary library to be able to connect to our database 
import pyodbc


remote_server = 'cowculator.ddns.net'  
port = '1433'  
database = 'Cowculator'  
username = 'Cowculator' 
password = '123' 


connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={remote_server};DATABASE={database};UID={username};PWD={password}'

def db_connect():
    try:
        conexion = pyodbc.connect(connection_string)
        print("Conexion Exitosa")
        return conexion

    except Exception as e:
        
        print(f"Error al conectarse: {e}")
