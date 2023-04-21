// import 'dart:collection';

// import 'package:routing/const.dart';

// class Node {
//   final double x, y;
//   final String name;
//   late HashMap<Node, double> cost;

//   Node(this.x, this.y, this.name);
// }

// class Truck {
//   int capacity = Backend.truckCapacity;
//   double cost = double.infinity;
// }

// class Algorithm {
//   late List<Node> nodes;
//   late List<Truck> trucks;
//   late Node start = Node(24, 15, "Start"), end = Node(24, 15, "End");
//   late List<List<Node>> paths;

//   Algorithm(this.nodes, this.trucks, this.start, this.end) {
//     nodes.add(start);
//     nodes.add(end);
//     nodes.add(Node(24, 12, "Andheri"));
//     nodes.add(Node(24, 12, "Vile Parle"));
//     nodes.add(Node(24, 12, "Jogeshwari"));
//     nodes.add(Node(24, 12, "Malad"));
//     nodes.add(Node(24, 12, "Santacruz"));
//     nodes.add(Node(24, 12, "Dahisar"));
//     nodes.add(Node(24, 12, "Vasai Road"));
//     nodes.add(Node(24, 12, "Virar"));
//     nodes.add(Node(24, 12, "Churchgate"));
//   }

//   void calCost(List<List<double>> distance, List<List<int>> traffic) {
//     print("Cal cost");
//     double cost;
//     for (int i = 0; i < nodes.length; i++) {
//       for (int j = 0; j < nodes.length - i; j++) {
//         cost = (distance[i][j] / Backend.truckSpeed) + traffic[i][j];

//         nodes[i].cost[nodes[j]] = cost;
//         nodes[j].cost[nodes[i]] = cost;
//       }
//     }

//     calPaths();
//   }

//   void calPaths() {
//     print("Cal paths");
//   }
// }
