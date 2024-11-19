from flask import Flask, request, render_template, redirect, url_for,session,jsonify
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

    print(session)
    #solo se popea una vez la ruta es recargada no cuando es accesada
    if 'user' in session and 'ranchId' in session['user']:
        session['user'].pop('ranchId')



    username = session['user']['username']
    ranch_data = db_methods.select_ranch(session['user']['user_id'])
   

    

    print(ranch_data)
    return render_template('myranch.html',user = username,ranch_data = ranch_data)

def convert_image(heximage):
    image = base64.b64encode(heximage).decode('utf-8')
    return image 

@app.route('/formmyranch')
def frommyranch_render():
    #agregar condicion max ranch
   return render_template('Formmyranch.html')

@app.route('/formmyranch_post', methods = ['POST','GET'])
def formmyranch_post():

    name = request.form['name']
    location = request.form['location']
    user_id = session['user']['user_id']
    image = request.files['image']



    if image is None:
        image = url_for('static', filename = 'images/dogallemand.jpg')
    else:
        image = image.read()
    

    
    db_methods.add_ranch(name,location,user_id,image)


    return redirect(url_for('myranch_render'))



@app.route('/mycattle')
def mycattle_render():
    ranch_id = request.args.get('ranchId')
    print(ranch_id)
    
    ranch_name = request.args.get('ranchName')
    
    session['user']['ranchId'] = ranch_id
    session.modified = True

    count = db_methods.count_cows(ranch_id)

   
    return render_template("MyCattle.html",name = ranch_name,id = ranch_id,totalCows = count)




#AJAX Calls

@app.route('/add_cow', methods=['POST'])
def add_cow():
    cow_data = request.json

    print(cow_data)

    name = cow_data['name']
    age = cow_data['age']
    breed = cow_data['breed']
    weight = cow_data['weight']

    new_cow = db_methods.add_cow(name,age,breed,weight,session['user']['ranchId'])
   
    return jsonify(new_cow)

@app.route('/search_cow',methods = ['POST'])
def search_cow():
    cowId = request.json
    
    cow_id = cowId['cowId']
    ranch_id = session['user']['ranchId']
    cow_info = db_methods.select_cow(cow_id,ranch_id)

    return jsonify(cow_info)

@app.route('/get_ranchs_data',methods = ['POST','GET'])
def get_ranchs_data():

    uid = session['user']['user_id']

    ranch_data = db_methods.select_ranch(uid)

    return jsonify(ranch_data)

@app.route('/transfer_cow', methods = ['POST'])
def transfer_cow():
    cow_data = request.json

    name = cow_data['name']
    age = cow_data['age']
    breed = cow_data['breed']
    weight = cow_data['weight']
    destination = cow_data['ranchId']











if __name__ == ("__main__"):
    app.run(debug= True)


#hola
