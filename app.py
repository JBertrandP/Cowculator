from flask import Flask, request, render_template, redirect, url_for,session
from werkzeug.security import generate_password_hash,check_password_hash
from backend import db_methods
import base64  




app = Flask(__name__, template_folder= "frontend/templates", static_folder= "frontend/static")  

app.secret_key = "hello"


@app.route("/")
def mainpage_render():
    return render_template('mainpage.html')

@app.route("/signuplogin")
def signuplogin_render():
    return render_template("LoginSignUp.html")


@app.route("/login_post", methods = ["POST"])
def login_post():
    email = request.form['email']
    password = request.form['password']

    password_hash = db_methods.get_hash(email)
    
    if db_methods.is_usuario(email)  is not None and check_password_hash(password_hash,password):

        user_id = db_methods.get_userData(email)[0]
        username = db_methods.get_userData(email)[1]
        email = db_methods.get_userData(email)[2]

        session['user'] = {'user_id' : None , 'email' : None , 'username' : None}
        
        session['user']['user_id'] = user_id
        session['user']['email'] =  email
        session['user']['username'] =  username
        
        print(session)
        return redirect(url_for('myranch_render'))
    else:
        return redirect(url_for("signuplogin_render"))



def verify_password(stored_password_hash, provided_password):
    return check_password_hash(stored_password_hash, provided_password)


@app.route('/signup_post', methods = ['POST'])
def signup_post():
    username = request.form['user']
    email = request.form['email']
    password = request.form['password']

    if( not (db_methods.is_usuario(email)) ):
        db_methods.add_user(username,email,generate_password_hash(password))

        user_id = db_methods.get_userData(email)[0]
        
        session['user'] = {'user_id' : None , 'email' : None , 'username' : None}

        session['user']['user_id'] = user_id
        session['user']['email'] = email
        session['user']['username'] = username
        
        
        return redirect(url_for('myranch_render'))
    else:
        return redirect(url_for('signuplogin_render'))


def hash_password(password):
    return generate_password_hash(password)


@app.route('/myranch')
def myranch_render():
    print(session)


    username = session['user']['username']
    ranch_data = db_methods.select_ranch(session['user']['user_id'])
    
    #ranch_data
    #ranch_data[0] Rancho 1
    #ranch_data[0][4] Rancho 1 Image
    print(ranch_data)
    print(ranch_data[0])
    print(ranch_data[0][1])
    #convertir imagenes 

    print(len(ranch_data))

    for i in range(0,len(ranch_data)):
        image = convert_image(ranch_data[i][4])
        ranch_data[i][4] = image

    return render_template('myranch.html',user = username,ranch_data = ranch_data)

def convert_image(heximage):
    image = base64.b64encode(heximage).decode('utf-8')
    return image 

@app.route('/formmyranch')
def frommyranch_render():
   return render_template('Formmyranch.html')

@app.route('/formmyranch_post', methods = ['POST','GET'])
def formmyranch_post():

    name = request.form['name']
    location = request.form['location']
    user_id = session['user']['user_id']
    image = request.files['image']



    if image is None:
        image = url_for('static', filename = 'images/dogallemand.jpg').read()
    else:
        image = image.read()
    

    
    db_methods.add_ranch(name,location,user_id,image)


    return redirect(url_for('myranch_render'))



@app.route('/mycattle')
def mycattle_render():
    return render_template("MyCattle.html")




if __name__ == ("__main__"):
    app.run(debug= True)


#hola
