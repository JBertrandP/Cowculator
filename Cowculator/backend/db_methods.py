from db_connection import db_connection

def is_usuario(user,correo,contraseña):

    try:
        conn = db_connection()
        cursor = conn.cursor()

        query = (f""" 
        DECLARE @Result BIT; 
        EXEC IsUsuario  '{user}',  '{correo}', '{contraseña}', 
        @Exist = @Result OUTPUT;  select @Result """)
        
      

        result = cursor.execute(query)

        row = result.fetchone()

        cursor.close()
        conn.close()

        return bool(row[0])
    
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

        query = (f" select * from Usuarios ")
        result = cursor.execute(query)

        row = cursor.fetchall
        

        conn.commit()
        cursor.close()
        conn.close()

        return print(row)

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")


"""""
User = "Liam"
Correo = "juancho2@gmail.com"
Contraseña = "juancho"


if is_usuario(User,Correo,Contraseña):
    
    print("Accede a la pagina")

else:

    print(f"El usuario {User} es invalido")

    print("Signup")
    User = input("Introduce un usuario: ")
    Correo = input("Introduce tu correo: ")
    Contraseña = input("Introduce una contraseña: ")

    add_user(User,Correo,Contraseña)
    select_all()


"""""













""""

#funciones necesarias para connexion e interaccion



    try:
        conn = db_connection()
        cursor = conn.cursor()

        query = (f" ")

        cursor.close()
        conn.close()

    except Exception as e:
        # Print the exception for debugging purposes
        print(f"Error al conectarse: {e}")







"""


