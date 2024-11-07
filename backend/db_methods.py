from . import db_connection

def is_usuario(correo):

    try:
        conn = db_connection.db_connect()
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
        conn = db_connection.db_connect()
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
        conn = db_connection.db_connect()
        cursor = conn.cursor()

        query = (f""" select PasswordHash from Users where Email = '{email}'

 """)
        result = cursor.execute(query)

        row = cursor.fetchone()
        

        conn.commit()
        cursor.close()
        conn.close()

        print(row[0])
        return row[0]

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def get_userData(email):
    try:
        conn = db_connection.db_connect()
        cursor = conn.cursor()

        query = (f""" select * from Users where Email = '{email}'

 """)
        result = cursor.execute(query)

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
        conn = db_connection.db_connect()
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


#add_user("Test","test@test.com","abcdefg")
#print(select_all())