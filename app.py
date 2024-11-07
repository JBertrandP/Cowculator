from flask import Flask, request, render_template, redirect, url_for,session
from werkzeug.security import generate_password_hash,check_password_hash
from backend import db_methods




app = Flask(__name__, template_folder= "frontend/templates", static_folder= "frontend/static")  

app.secret_key = "hello"


@app.route("/")
def mainpage_render():
    return render_template('mainpage.html')

@app.route("/signuplogin")
def signuplogin_render():
    status = request.args.get('status')
    return render_template("LoginSignUp.html",status = status)



@app.route('/signup_post', methods = ['POST'])
def signup_post():
    user = request.form['user']
    email = request.form['email']
    password = request.form['password']

    if( not (db_methods.is_usuario(email)) ):
        db_methods.add_user(user,email,generate_password_hash(password))
        session['user'] = request.form['user']
        return redirect(url_for('myranch_render',user = user))
    else:
        return redirect(url_for('signuplogin_render'))


def hash_password(password):
    return generate_password_hash(password)




@app.route("/login_post", methods = ["POST"])
def login_post():
    email = request.form['email']
    password = request.form['password']

    password_hash = db_methods.get_hash(email)
    
    if db_methods.is_usuario(email)  is not None and check_password_hash(password_hash,password):

        user = db_methods.get_userData(email)[1]
        return redirect(url_for('myranch_render',user = user))
    else:
        return redirect(url_for("signuplogin_render"))



def verify_password(stored_password_hash, provided_password):
    return check_password_hash(stored_password_hash, provided_password)


@app.route('/myranch')
def myranch_render():

    user = request.args.get('user')
    return render_template('myranch.html',user = user)
  

@app.route('/formmyranch')
def frommyranch_render():
   return render_template('Formmyranch.html')

@app.route('/myranch_post')
def myranch_post():
    name = request.form['name']
    location = request.json
    image = request.files['image']

    




@app.route('/mycattle')
def mycattle_render():
    return render_template("MyCattle.html")


if __name__ == ("__main__"):
    app.run(debug= True)


#hola
