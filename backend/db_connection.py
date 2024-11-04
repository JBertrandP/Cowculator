#we import the neccessary library to be able to connect to our database 
import pyodbc


remote_server = 'localhost'  # e.g., '192.168.1.100' or 'myremoteserver.com'
port = '1433'  # or your specific port number
database = 'Cowculator'  # e.g., 'mydb'
username = 'Cowculator'  # e.g., 'sa'
password = '123'  # e.g., 'your_password'


connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={remote_server};DATABASE={database};UID={username};PWD={password}'

def db_connect():
    try:
        conexion = pyodbc.connect(connection_string)
        print("Conexion Exitosa")
        return conexion

    except Exception as e:
        
        print(f"Error al conectarse: {e}")
