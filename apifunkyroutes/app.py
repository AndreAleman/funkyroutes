from flask import Flask, request, jsonify # Importing necessary modules from flask
import json # Importing json module for json operations

app = Flask(__name__) # Creating a Flask web server from the Flask module




@app.route('/receive_user_data', methods=['POST', 'GET'])
def receive_user_data():
    global houses_data
    global depot_data
    
    data = request.json
    username = data['username']
    user_addresses = data['addresses']
    user_home = data['home']
    depot_data = f'{user_home["Street"]}, {user_home["City"]}, {user_home["State"]}'
    houses_data = json.dumps(user_addresses)
    
    print(f'Username: {username}\n')
    print(f'Home: {depot_data}\n')
    print('Addresses:')
    for address in user_addresses:
        address_str = f'{address["Street"]}, {address["City"]}, {address["State"]}'
        print(address_str)
    
    return 'Data received', 200

@app.route('/get_houses', methods=['GET'])
def get_houses():
    addresses = json.loads(houses_data)
    response = f'Home: {depot_data}<br>'
    response += 'Addresses: <br>'
    for address in addresses:
        address_str = f'{address["Street"]}, {address["City"]}, {address["State"]}'
        response += f'{address_str}<br>'
    
    return response, 200


@app.route('/hello', methods=['GET']) # This decorator creates an API endpoint for a simple hello world message
def hello_world():
    message = request.args.get('message', 'Hello World') # Get the message from the request arguments, default is 'Hello World'
    return message # Return the message



############################################

if __name__ == '__main__': # This line ensures the script is run directly, not imported as a module
    app.run(host='0.0.0.0', port=5000, debug=True) # Run the Flask web server
