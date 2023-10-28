from flask import Flask, request
app = Flask(__name__)

@app.route('/receive_user_data', methods=['POST'])
def receive_user_data():
    
    data = request.json # Get the JSON data from the POST request
   
    username = data['username']  # Extract the username from the JSON data
   
    addresses = data['addresses']  # Extract the addresses from the JSON data
    
    print(f'Username: {username}') # Print the username
    
    print('Addresses:') # Print the addresses
    for address in addresses:
        print(address)
    # Return a response indicating that the data was received successfully
    return 'Data received', 200

if __name__ == '__main__':
    # Run the Flask application
    app.run(debug=True)
