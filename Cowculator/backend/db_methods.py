from db_connection import db_connection

def is_usuario(user,correo,contraseña):

    try:
        conn = db_connection()
        cursor = conn.cursor()

        query = (f""" 
        select * from Users where '{user}' = Username and '{correo}' = Email and '{contraseña}' = PasswordHash 

        """)
        result = cursor.execute(query)

        cursor.close()
        conn.close()
        return result
    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")





def add_user(user,correo,contraseña):
    try:
        conn = db_connection()
        cursor = conn.cursor()

        query = (f" exec add_usuario '{user}','{correo}','{contraseña}' ")
        cursor.execute(query)

        conn.commit()
        cursor.close()
        conn.close()

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


def select_all():
    try:
        conn = db_connection()
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


print( is_usuario( 'Juanito','juan@gmail.com','qqqqqq'))





