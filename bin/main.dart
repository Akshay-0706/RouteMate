import 'dart:collection';

// import 'package:routing/const.dart';

class Backend {
  static int truckCapacity = 0;
  static int truckSpeed = 20;
}

class Node {
  final double x, y;
  final String name;
  HashMap<Node, double> cost = HashMap();

  Node(this.x, this.y, this.name);
}

class Truck {
  int capacity = Backend.truckCapacity;
  double cost = double.infinity;
}

class Algorithm {
  late List<Node> nodes;
  late List<Truck> trucks;
  late Node start = Node(24, 15, "Start"), end = Node(24, 15, "End");
  late List<List<Node>> paths;

  Algorithm(this.nodes, this.trucks, this.start, this.end) {
    // nodes.add(start);
    // nodes.add(end);
    // nodes.add(Node(24, 12, "Andheri"));
    // nodes.add(Node(24, 12, "Vile Parle"));
    // nodes.add(Node(24, 12, "Jogeshwari"));
    // nodes.add(Node(24, 12, "Malad"));
    // nodes.add(Node(24, 12, "Santacruz"));
    // nodes.add(Node(24, 12, "Dahisar"));
    // nodes.add(Node(24, 12, "Vasai Road"));
    // nodes.add(Node(24, 12, "Virar"));
    // nodes.add(Node(24, 12, "Churchgate"));
  }

  void calCost(List<List<double>> distance, List<List<int>> traffic) {
    print("Cal cost");
    double cost;
    for (int i = 0; i < nodes.length - 1; i++) {
      for (int j = 0; j < nodes.length - i - 1; j++) {
        cost = (distance[i][j] / Backend.truckSpeed) + traffic[i][j];

        nodes[i].cost[nodes[j]] = cost;
        nodes[j].cost[nodes[i]] = cost;
      }
    }

    calPaths();
  }

  void calPaths() {
    print("Cal paths\n");
    for (var node in nodes) {
      print("for ${node.name}: ");
      for (var cost in node.cost.entries) {
        print("${cost.key.name} = ${cost.value}");
      }
      print("");
    }
  }
}

void main(List<String> args) {
  print("Hello world!");

  List<Node> nodes = [];
  List<Truck> trucks = [];

  Node start = Node(12, 24, "Start");
  Node end = Node(12, 24, "End");

  nodes.add(start);
  nodes.add(end);
  nodes.add(Node(24, 12, "Andheri"));
  nodes.add(Node(24, 12, "Vile Parle"));
  nodes.add(Node(24, 12, "Jogeshwari"));
  // nodes.add(Node(24, 12, "Malad"));
  // nodes.add(Node(24, 12, "Santacruz"));
  // nodes.add(Node(24, 12, "Dahisar"));
  // nodes.add(Node(24, 12, "Vasai Road"));
  // nodes.add(Node(24, 12, "Virar"));
  // nodes.add(Node(24, 12, "Churchgate"));

  Algorithm algorithm = Algorithm(nodes, trucks, start, end);

  /*
  12 34 56 23
  16 53 74
  23 54
  67
  */

  /*
  0 0 0 0
  0 0 0
  0 0
  0
  */

  List<List<double>> distance = [];
  List<List<int>> traffic = [];

  distance.add([12, 34, 56, 23]);
  distance.add([16, 53, 74]);
  distance.add([23, 54]);
  distance.add([67]);

  traffic.add([0, 0, 0, 0]);
  traffic.add([0, 0, 0]);
  traffic.add([0, 0]);
  traffic.add([0]);

  algorithm.calCost(distance, traffic);
}
