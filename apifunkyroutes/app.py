from flask import Flask, request, jsonify
import json

app = Flask(__name__)

houses_data = [] #global to store houses

@app.route('/receive_user_data', methods=['POST', 'GET'])
def receive_user_data():
    
    global houses_data
    data = request.json # Get the JSON data from the POST request
    username = data['username']  # Extract the username from the JSON data
    addresses = data['addresses']  # Extract the addresses from the JSON data
    houses_data = json.dumps(addresses) # Convert addresses to JSON string and store it in houses_data
    print(f'Username: {username}') # Print the username
    print(f'this is houses data: {houses_data}')

    print('Addresses:') # Print the addresses
    for address in addresses:
        print(address)
    # Return a response indicating that the data was received successfully
    return 'Data received', 200


@app.route('/get_houses', methods=['GET'])
def get_houses():
    # Your code to retrieve and return the houses data
    return houses_data


@app.route('/hello', methods=['GET'])
def hello_world():
    message = request.args.get('message', 'Hello World')
    return message



############################################

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)