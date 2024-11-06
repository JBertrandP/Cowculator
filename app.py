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

    if( not (db_methods.is_usuario(email,password)) ):
        db_methods.add_user(user,email,generate_password_hash(password))
        return redirect(url_for('myranch_render',user = user))


def hash_password(password):
    return generate_password_hash(password)




@app.route("/login_post", methods = ["POST"])
def login_post():
    email = request.form['email']
    password = request.form['password']

    password_hash = db_methods.get_hash(email)
    
    if db_methods.is_usuario(email)  is not None and check_password_hash(password_hash,password):
        return redirect(url_for('myranch_render',user = email))
    else:
        return redirect(url_for("signuplogin_render"))



def verify_password(stored_password_hash, provided_password):
    return check_password_hash(stored_password_hash, provided_password)


@app.route('/myranch')
def myranch_render():
    

    if request.args.get('user') :
        user = request.args.get('user') 
        return render_template('myranch.html',user = user)
    else: 
        user = ''
        return redirect(url_for('signuplogin_render'))


@app.route('/formmyranch')
def frommyranch_render():
   return render_template('Formmyranch.html')






@app.route('/mycattle')
def mycattle_render():
    return render_template("MyCattle.html")


if __name__ == ("__main__"):
    app.run(debug= True)


#hola
