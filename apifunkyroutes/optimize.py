from ortools.constraint_solver import routing_enums_pb2
from ortools.constraint_solver import pywrapcp


def optimize_route(returned_matrix, all_houses):

    print(f'All OPTIMIZEHouses: {all_houses}')
    #create the routing index manager
    manager = pywrapcp.RoutingIndexManager(len(returned_matrix), 1, 0)
    print(len(returned_matrix))
    print(len(all_houses))

    #create routing model
    routing = pywrapcp.RoutingModel(manager)

    #create distance call back.
    def distance_callback(from_index, to_index):
        return returned_matrix[from_index]['elements'][to_index]['duration']['value']
    
    transit_callback_index = routing.RegisterTransitCallback(distance_callback)

    #define cost of each arc
    routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

    #set 0th node as depot
   # routing.SetDepot(0)

    #Set the search parameters
    search_parameters = pywrapcp.DefaultRoutingSearchParameters()
    search_parameters.first_solution_strategy = (
        routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC)
    
    #solve the problem
    solution = routing.SolveWithParameters(search_parameters)




# Instead of returning just the indices of the optimized route, let's return the actual addresses in the correct order.
# Update the code inside the while loop to append the addresses to the optimized_route list instead of the node indices.

    # get optimized route
    optimized_route = []
    index = routing.Start(0)
    while not routing.IsEnd(index):
        node_index = manager.IndexToNode(index)
        optimized_route.append(all_houses[node_index])
        index = solution.Value(routing.NextVar(index))

    return optimized_route