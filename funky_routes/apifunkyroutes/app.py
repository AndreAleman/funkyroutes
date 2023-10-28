# Import the necessary packages
from flask import Flask, request, jsonify

# Create a Flask application
app = Flask(__name__)

# Define a route to receive user data
@app.route('/receive_user_data', methods=['POST'])
def receive_user_data():
    # Get the JSON data from the POST request
    data = request.json

    # Extract the username from the JSON data
    username = data['username']
    # Extract the addresses from the JSON data
    addresses = data['addresses']

    # Print the username
    print(f'Username: {username}')

    # Print the addresses
    print('Addresses:')
    for address in addresses:
        print(address)

    # Return the addresses as a JSON response
    return jsonify(addresses), 200

# Main function to run the Flask application
if __name__ == '__main__':
    app.run(debug=True)