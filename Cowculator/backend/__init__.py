# Initialize Flask app

from flask import Flask, request, render_template, redirect, url_for

app = Flask(__name__)  

@app.route("/")
def indx_render():
    return render_template('index.html')



if __name__ == ("__main__"):
    app.run(debug= True)
