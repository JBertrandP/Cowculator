from backend.db_connection import db_connect

def is_usuario(correo,contraseña):

    try:
        conn = db_connect()
        cursor = conn.cursor()

        query = (f""" 
        select * from Users where '{correo}' = Email and '{contraseña}' = PasswordHash 

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





