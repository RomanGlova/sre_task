#!/usr/local/bin/python

from flask import Flask
from flaskext.mysql import MySQL
import configparser

mysql = MySQL()
app = Flask(__name__)

config = configparser.ConfigParser()
config.read('.env')

app.config['MYSQL_DATABASE_USER'] = config.get('mysql', 'MYSQL_USER')
app.config['MYSQL_DATABASE_PASSWORD'] = config.get('mysql', 'MYSQL_PASSWORD')
app.config['MYSQL_DATABASE_DB'] = config.get('mysql', 'MYSQL_DATABASE')
app.config['MYSQL_DATABASE_HOST'] = 'db'
mysql.init_app(app)


@app.route("/message")
def message():
    cursor = mysql.connect().cursor()
    cursor.execute("SELECT message from mytable where 1")
    return cursor.fetchone()


if __name__ == "__main__":
    app.run()
