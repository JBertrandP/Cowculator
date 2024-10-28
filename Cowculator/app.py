# Main Flask application 


from flask import Flask, request, render_template, redirect, url_for

app = Flask(__name__, template_folder= "frontend/templates")  

@app.route("/")
def indx_render():
    return render_template('mainpage.html')





if __name__ == ("__main__"):
    app.run(debug= True)


#hola
