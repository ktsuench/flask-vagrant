from flask import Flask, jsonify
from pymongo import MongoClient

app = Flask(__name__)

@app.route('/')
def index():
  return 'Flask is running!'

@app.route('/data')
def names():
  data = {"names":["John","Jacob","Julie","Jennifer"]}
  return jsonify(data)

@app.route('/mongo')
def mongo():
  client = MongoClient('localhost', 27017)
  db = client.flask
  usersCollection = db.users

  if(not "users" in db.collection_names(include_system_collections=False)): 
    users = [
      {
        "name": "test",
        "email": "test@test.test",
        "age": 10
      },
      {
        "name": "mary",
        "email": "mary@test.test",
        "age": 21
      },
      {
        "name": "john",
        "email": "john@test.test",
        "age": 15
      }
    ]

    for user in users:
      usersCollection.insert_one(user)

  user = usersCollection.find_one({"name":"test"})

  return user['email']

if __name__ == '__main__':
  app.run(port=8080);
