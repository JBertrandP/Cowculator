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

def update_ranch_contador(total_cows,total_sick,farm_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()


        query = (f" update MyRanch set TotalCows = ?, TotalSickCows = ? where FarmID = ?")
        cursor.execute(query,(total_cows,total_sick,farm_id))


        conn.commit()
        cursor.close()
        conn.close()
        


    except Exception as e:
        print(e)




def get_ranch_contador(farm_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()


        query = (f"select TotalCows,TotalSickCows from MyRanch where FarmID = ?")
        cursor.execute(query,(farm_id))

        columns = [column[0] for column in cursor.description]
        rows = [cursor.fetchone()]



        conn.commit()
        cursor.close()
        conn.close()

        return dictionarify(columns,rows)
        


    except Exception as e:
        print(e)


def is_owner(user_id,ranch_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()


        query = (f" select FarmID from MyRanch where OwnerID = ? and FarmID = ? ")
        cursor.execute(query,(user_id,ranch_id))

        data = cursor.fetchone()

        conn.commit()
        cursor.close()
        conn.close()
        
        return data
    

    except Exception as e:
        print(e)


def add_cow(name,age,breed,weight,ranch_id,status):
    try:
        conn = db_connect()
        cursor = conn.cursor()
        
        query = (f" insert into Cows(CowName,Age,Breed,Weight,FarmID,Status) values  (?,?,?,?,?,?) ")
        cursor.execute(query,(name,age,breed,weight,ranch_id,status))

        query = (f"  SELECT TOP 1 * FROM cows ORDER BY CowID DESC;")
        cursor.execute(query)

        columns = [column[0] for column in cursor.description]
        rows = [cursor.fetchone()]

        conn.commit()
        cursor.close()
        conn.close()    

        print('Print desde db_methods')
        print(dictionarify(columns,rows))

        return dictionarify(columns,rows)
    except Exception as e:
        print(e)
        
def update_cow(cow_info):
    try:

        print('UpdateCow  db_methods')
        print(cow_info)

        name = cow_info['name']
        age = cow_info['age']
        breed = cow_info['breed']
        weight = cow_info['weight']
        cow_id = cow_info['cowId']

        conn = db_connect()
        cursor = conn.cursor()

        query = (f"  update Cows set CowName = ?, age = ?, Breed = ?, Weight = ? where  CowID = ?")
        cursor.execute(query,(name, age , breed , weight,cow_id))


        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        print(e)





def delete_cow(cow_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()
        
        query = (f" delete from Cows where CowID = ? ")
        cursor.execute(query,cow_id)


        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        print(e)





# se necesitan todos los datos de la vaca
def transfer_cow(cowData):
    try:
        print(cowData)
       
        conn = db_connect()
        cursor = conn.cursor()

        query = """

            update Cows set FarmID = ? where CowID = ?
        """

        cursor.execute(query,(cowData['Destination'],cowData['CowID']))
        

        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        print(e)

        


def count_cows(type,ranch_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()
        
        query = (f"select count(*) as count from Cows where FarmID = ? {type} ")
        cursor.execute(query,ranch_id)

        count = cursor.fetchone()

        conn.commit()
        cursor.close()
        conn.close()

        return count[0]
    except Exception as e:
        print(e)


def select_cow(cow_id,ranch_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()
        
        query = (f"  select * from Cows where CowID = ? and FarmID = ?")
        cursor.execute(query,(cow_id,ranch_id))

        columns = [column[0] for column in cursor.description]
        rows = [cursor.fetchone()]

        conn.commit()
        cursor.close()
        conn.close()

        return dictionarify(columns,rows)
    except Exception as e:
        print(e)


def recently_added(ranch_id):
    try:
        conn = db_connect()
        cursor = conn.cursor()
        
        query = (f" select top 4 * from Cows where FarmID = ? ORDER by CowID Desc ")
        cursor.execute(query,(ranch_id))

        columns = [column[0] for column in cursor.description]
        rows = cursor.fetchall()    

        conn.commit()
        cursor.close()
        conn.close()

        return dictionarify(columns,rows)
    except Exception as e:
        print(e)   







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