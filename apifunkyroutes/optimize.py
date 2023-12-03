from ortools.constraint_solver import routing_enums_pb2
from ortools.constraint_solver import pywrapcp

def optimize_route(returned_matrix, all_houses):
   
   # print(f'All OPTIMIZEHouses: {all_houses}')

   length = len(returned_matrix['rows'])

   manager = pywrapcp.RoutingIndexManager(length, 1, 0)

   # Create routing model
   routing = pywrapcp.RoutingModel(manager)

   def distance_callback(from_index, to_index):
       from_node = manager.IndexToNode(from_index)
       to_node = manager.IndexToNode(to_index)
       #print('distance callback')
       #print(returned_matrix['rows'][from_node]['elements'][to_node]['duration']['value'])
       return returned_matrix['rows'][from_node]['elements'][to_node]['distance']['value']


   transit_callback_index = routing.RegisterTransitCallback(distance_callback)

   # Define cost of each arc
   routing.SetArcCostEvaluatorOfAllVehicles(transit_callback_index)

   # Set 0th node as depot
   #routing.SetDepot(0)

   # Set the search parameters
   search_parameters = pywrapcp.DefaultRoutingSearchParameters()
   search_parameters.first_solution_strategy = (
       routing_enums_pb2.FirstSolutionStrategy.PATH_MOST_CONSTRAINED_ARC)
   
   # Solve the problem
   solution = routing.SolveWithParameters(search_parameters)

   # Get optimized route
   optimized_route = []
   index = routing.Start(0)
   while not routing.IsEnd(index):
       node_index = manager.IndexToNode(index)
       optimized_route.append(all_houses[node_index])
       index = solution.Value(routing.NextVar(index))

   return optimized_route