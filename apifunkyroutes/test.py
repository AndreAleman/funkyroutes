from optimize import optimize_route

# Define the distance matrix
returned_matrix = {
    'elements': [
        {'duration': {'value': 0}},
        {'duration': {'value': 10}},
        {'duration': {'value': 20}},
        {'duration': {'value': 30}},
        {'duration': {'value': 40}},
        {'duration': {'value': 50}},
        {'duration': {'value': 60}}
    ]
}

# Define the list of addresses
all_houses = [
    'House 0',
    'House 1',
    'House 2',
    'House 3',
    'House 4',
    'House 5',
    'House 6'
]

# Call the optimize_route function
optimized_route = optimize_route(returned_matrix, all_houses)

# Print the optimized route
print(optimized_route)