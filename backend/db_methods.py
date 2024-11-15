from .db_connection import db_connect
import json
import base64

def is_usuario(correo):

    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f""" 
        select * from Users where '{correo}' = Email 

        """)
        result = cursor.execute(query)
        row = result.fetchall()

        cursor.close()
        conn.close()
        return row
    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")





def add_user(user,correo,contraseña):
    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f"insert into Users( Username,Email,PasswordHash) values ('{user}','{correo}','{contraseña}')  ")
        cursor.execute(query)

        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")



def get_hash(email):
    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f""" select PasswordHash from Users where Email = '{email}'

 """)
        cursor.execute(query)

        row = cursor.fetchone()
        

        conn.commit()
        cursor.close()
        conn.close()

        return row[0]

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def get_userData(email):
    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f""" select * from Users where Email = '{email}'

 """)
        cursor.execute(query)

    
        row = cursor.fetchone()
        

        conn.commit()
        cursor.close()
        conn.close()

        return row

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def select_all():
    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f" select * from Users ")
        result = cursor.execute(query)

        row = cursor.fetchall()
        

        conn.commit()
        cursor.close()
        conn.close()

        return print(row)

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")






def add_ranch(name,location,user_id,image):
    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (""" 
        insert into MyRanch(FarmName,Location,OwnerID,FarmImage) values ( ?, ?, ?, ? ) 
        """)


        cursor.execute(query,(name,location,user_id,image))


        conn.commit()
        cursor.close()
        conn.close()

        return 

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def select_ranch(user_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()

       
        query = (f" select * from MyRanch where OwnerID = ? ")
        cursor.execute(query,user_id)


        columns = [column[0] for column in cursor.description]
        row = cursor.fetchall()

        
        for ranch in row:
            image = convert_image(ranch[4])
            ranch[4] = image


        conn.commit()
        cursor.close()
        conn.close()

        
        return dictionarify(columns,row)
        

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def add_cow(name,age,breed,weight,ranch_id):
    conn = db_connect()
    cursor = conn.cursor()
       
    query = (f" insert into Cows(CowName,Age,Breed,Weight,FarmID) values  (?,?,?,?,?) ")
    cursor.execute(query,(name,age,breed,weight,ranch_id))

    query = (f"  SELECT TOP 1 * FROM cows ORDER BY CowID DESC;")
    cursor.execute(query)

    columns = [column[0] for column in cursor.description]
    row = [cursor.fetchone()]

    conn.commit()
    cursor.close()
    conn.close()

    return dictionarify(columns,row)


def count_cows(ranch_id):
    conn = db_connect()
    cursor = conn.cursor()
       
    query = (f"  select count(*) as count from Cows where FarmID = ? ")
    cursor.execute(query,ranch_id)

    count = cursor.fetchone()

    conn.commit()
    cursor.close()
    conn.close()

    return count[0]


def select_cow(cow_id):
    conn = db_connect()
    cursor = conn.cursor()
       
    query = (f"  select count(*) as count from Cows where FarmID = ? ")
    cursor.execute(query,cow_id)

    count = cursor.fetchone()

    conn.commit()
    cursor.close()
    conn.close()




def dictionarify(colums,rows):
    try:

        result =  [ dict(zip(colums,row)) for row in rows ]  
        
        
        return result
    
    except Exception as e:
        # Print the exception for debugging purposes
        print(f" Error en la creacion del diccionario: {e}")




def convert_image(heximage):
    image = base64.b64encode(heximage).decode('utf-8')
    return image 


#add_user("Test","test@test.com","abcdefg")
#print(select_all())