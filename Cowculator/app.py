#Main Flask application 
#from backend import db_methods
from flask import Flask, request, render_template, redirect, url_for
from backend import db_methods



app = Flask(__name__, template_folder= "frontend/templates", static_folder= "frontend/static")  



@app.route("/")
def mainpage_render():
    return render_template('mainpage.html')

@app.route("/signup")
def signup_render():
    status = request.args.get('status')
    return render_template("LoginSignUp.html",status = status)

@app.route("/login_post", methods = ["POST"])
def login_post():
    email = request.form['email']
    password = request.form['password']



    if(db_methods.is_usuario(email,password)):
        return redirect(url_for('myranch_render',user = email))
    else:
        return redirect(url_for("signup_render",status = 'Invalid Email or Password'))



@app.route('/myranch')
def myranch_render():
    
    user = request.args.get('user') 
    return render_template('myranch.html',user = user)


"""""
@app.route("/login_signup")
def login_signup_render():
    return render_template("LoginSignUp.html")


@app.route("signup_post")
def signup_post():
    return

"""



if __name__ == ("__main__"):
    app.run(debug= True)


#hola
