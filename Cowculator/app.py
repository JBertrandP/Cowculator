#Main Flask application 
#from backend import db_methods
from flask import Flask, request, render_template, redirect, url_for



app = Flask(__name__, template_folder= "frontend/templates", static_folder= "frontend/static")  



@app.route("/")
def mainpage_render():
    return render_template('mainpage.html')

@app.route("/signup")
def signup_render():
    return render_template("LoginSignUp.html")






"""""
@app.route("/login_signup")
def login_signup_render():
    return render_template("LoginSignUp.html")

@app.route("login_post")
def login_post():
    return

@app.route("signup_post")
def signup_post():
    return

"""



if __name__ == ("__main__"):
    app.run(debug= True)


#hola
