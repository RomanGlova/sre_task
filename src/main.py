#!/usr/local/bin/python

from flask import Flask
from flaskext.mysql import MySQL
import os

mysql = MySQL()
app = Flask(__name__)

app.config['MYSQL_DATABASE_USER'] = os.environ['MYSQL_USER']
app.config['MYSQL_DATABASE_PASSWORD'] = os.environ['MYSQL_PASSWORD']
app.config['MYSQL_DATABASE_DB'] = os.environ['MYSQL_DATABASE']
app.config['MYSQL_DATABASE_HOST'] = os.environ['DB_HOST']

mysql.init_app(app)


@app.route("/message")
def message():
    cursor = mysql.connect().cursor()
    cursor.execute('''SELECT message from mytable where 1''')
    result = cursor.fetchall()
    cursor.close()
    return str(result)


@app.route("/")
def root():
    return "Test app"


@app.route("/create_table")
def create_table():
    cursor = mysql.connect().cursor()
    cursor.execute('''CREATE TABLE mytable(
    id INT NOT NULL AUTO_INCREMENT, message VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
    )''')
    result = cursor.fetchall()
    cursor.close()
    return str(result)


@app.route("/insert")
def insert_data():
    cursor = mysql.connect().cursor()
    cursor.execute('''INSERT INTO mytable(message) VALUES ('Hello World!'), ('foo'), ('bar')''')
    result = cursor.fetchall()
    cursor.close()
    return str(result)


if __name__ == "__main__":
    app.run(host='0.0.0.0')
