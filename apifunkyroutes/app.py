from flask import Flask, request, jsonify # Importing necessary modules from flask
import json # Importing json module for json operations
import googlemaps # Importing googlemaps module for google maps api operations
from config import api_key # Importing api_key from config.py
from optimize import optimize_route

app = Flask(__name__) # Creating a Flask web server from the Flask module

gmaps = googlemaps.Client(key=api_key) # Creating a googlemaps client object with the api_key

def print_keys(nested_dict, parent_key=''):
  for key, value in nested_dict.items():
      full_key = f"{parent_key}.{key}" if parent_key else key
      print('  ' * full_key.count('.') + full_key, type(value))
      if isinstance(value, dict):
          print_keys(value, full_key)

@app.route('/receive_user_data', methods=['POST', 'GET'])
def receive_user_data():

   global houses_data
   global depot_data
   global all_houses
   
   data = request.json
   username = data['username']
   user_addresses = data['addresses']
   user_home = data['home']
   depot_data = f'{user_home["Street"]}, {user_home["City"]}, {user_home["State"]}'

   houses_data = [f'{address["Street"]}, {address["City"]}, {address["State"]}' for address in user_addresses]

   print(f'Username: {username}\n')
   print(f'Home: {depot_data}\n')
   print('All Addresses:')
   
   for address in houses_data:
       print(address)
   
   all_houses = [depot_data] + houses_data

   returned_matrix = gmaps.distance_matrix(all_houses, all_houses)
   print("before optimize route")
   print(returned_matrix)
   print("\n")

   length = len(returned_matrix['rows'])
   print(f'length: {length}')
   print("Structure of returned_matrix:")
   print_keys(returned_matrix)
   print("\n")

   optimized_route = optimize_route(returned_matrix, all_houses)

   print("Optimized Route:")
   for i, address in enumerate(optimized_route):
        print(f"House {i}: {address}")





   return 'Data received', 200





@app.route('/get_houses', methods=['GET'])
def get_houses():
    addresses = all_houses


    response = f'Home: {all_houses}<br>'
    response += 'Addresses: <br>'

    for address in addresses:
        response += f'{address}<br>'
    
    return response, 200


@app.route('/hello', methods=['GET']) # This decorator creates an API endpoint for a simple hello world message
def hello_world():
    message = request.args.get('message', 'Hello World') # Get the message from the request arguments, default is 'Hello World'
    return message # Return the message



############################################

if __name__ == '__main__': # This line ensures the script is run directly, not imported as a module
    app.run(host='0.0.0.0', port=5000, debug=True) # Run the Flask web server









    #returned_matrix = returned_matrix['rows']
    #for i, row in enumerate(returned_matrix):
   #     elements = row['elements']
  #      for j, element in enumerate(elements):
            #distance = element['distance']['text']
 #           duration = element['duration']['text']

            #print(f"Distance from {all_houses[i]} to {all_houses[j]}: {distance}")
#            print(f"Duration from {all_houses} to {all_houses[j]}: {duration}")
