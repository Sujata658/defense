import 'dart:convert';

Map<String, dynamic> jsonVehicle = {
  "vehicles": [
    {
      "id": 1,
      "name": "Sajha Bus",
      "type": "bus",
      "routes": [
        {
          "id": 1,
          "name": "S1",
          "starting_point": "A",
          "final_point": "F",
          "vehicle": 1
        },
        {
          "id": 2,
          "name": "S2",
          "starting_point": "G",
          "final_point": "L",
          "vehicle": 1
        }
      ],
      "fares": [
        {
          "id": 1,
          "start_location": "A",
          "end_location": "B",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 2,
          "start_location": "A",
          "end_location": "C",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 3,
          "start_location": "A",
          "end_location": "D",
          "fare": "15.00",
          "route": 1
        },
        {
          "id": 4,
          "start_location": "A",
          "end_location": "E",
          "fare": "20.00",
          "route": 1
        },
        {
          "id": 5,
          "start_location": "A",
          "end_location": "F",
          "fare": "25.00",
          "route": 1
        },
        {
          "id": 7,
          "start_location": "B",
          "end_location": "C",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 8,
          "start_location": "B",
          "end_location": "D",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 9,
          "start_location": "B",
          "end_location": "D",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 10,
          "start_location": "B",
          "end_location": "E",
          "fare": "15.00",
          "route": 1
        },
        {
          "id": 11,
          "start_location": "B",
          "end_location": "E",
          "fare": "20.00",
          "route": 1
        },
        {
          "id": 12,
          "start_location": "C",
          "end_location": "D",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 13,
          "start_location": "C",
          "end_location": "E",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 14,
          "start_location": "C",
          "end_location": "F",
          "fare": "15.00",
          "route": 1
        },
        {
          "id": 15,
          "start_location": "D",
          "end_location": "E",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 16,
          "start_location": "D",
          "end_location": "F",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 17,
          "start_location": "E",
          "end_location": "F",
          "fare": "5.00",
          "route": 1
        }
      ]
    },
    {
      "id": 2,
      "name": "Tempo",
      "type": "tempo",
      "routes": [
        {
          "id": 1,
          "name": "S1",
          "starting_point": "A",
          "final_point": "F",
          "vehicle": 1
        },
        {
          "id": 2,
          "name": "S2",
          "starting_point": "G",
          "final_point": "L",
          "vehicle": 1
        }
      ],
      "fares": [
        {
          "id": 1,
          "start_location": "A",
          "end_location": "B",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 2,
          "start_location": "A",
          "end_location": "C",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 3,
          "start_location": "A",
          "end_location": "D",
          "fare": "15.00",
          "route": 1
        },
        {
          "id": 4,
          "start_location": "A",
          "end_location": "E",
          "fare": "20.00",
          "route": 1
        },
        {
          "id": 5,
          "start_location": "A",
          "end_location": "F",
          "fare": "25.00",
          "route": 1
        },
        {
          "id": 7,
          "start_location": "B",
          "end_location": "C",
          "fare": "5.00",
          "route": 1
        },
        {
          "id": 8,
          "start_location": "B",
          "end_location": "D",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 9,
          "start_location": "B",
          "end_location": "D",
          "fare": "10.00",
          "route": 1
        },
        {
          "id": 10,
          "start_location": "B",
          "end_location": "E",
          "fare": "15.00",
          "route": 1
        },
        {
          "id": 11,
          "start_location": "B",
          "end_location": "E",
          "fare": "20.00",
          "route": 1
        },
        {
          "id": 12,
          "start_location": "C",
          "end_location": "D",
          "fare": "5.00",
          "route": 1
        }
      ]
    },
    {
      "id": 3,
      "name": "Nepal Yatayat",
      "type": "bus",
      "routes": [],
      "fares": []
    },
    {
      "id": 4,
      "name": "Micro Bus",
      "type": "microbus",
      "routes": [],
      "fares": []
    }
  ]
};
List<Map<String, Object>> jsonRoute = [
  {
    "id": 1,
    "name": "S1",
    "starting_point": "A",
    "final_point": "F",
    "stops": ["a", "b", "c", "d"],
    "vehicle": 1
  },
  {
    "id": 2,
    "name": "S2",
    "starting_point": "G",
    "final_point": "L",
    "stops": ["a", "b", "c", "d"],
    "vehicle": 1
  },
  {
    "id": 3,
    "name": "route1",
    "starting_point": "balkumari",
    "final_point": "sukedhara",
    "stops": ["a", "b", "c", "d"],
    "vehicle": 5
  },
  {
    "id": 4,
    "name": "micro-route1",
    "starting_point": "lagankhel",
    "final_point": "ratnapark",
    "stops": ["kumaripati", "pulchowk", "kupondole", "maitighar"],
    "vehicle": 4
  },
  {
    "id": 5,
    "name": "tempo-route1",
    "starting_point": "lagankhel",
    "final_point": "ratnapark",
    "stops": ["kumaripati", "pulchowk", "kupondole", "maitighar"],
    "vehicle": 2
  },
  {
    "id": 6,
    "name": "nepalyatayat-route1",
    "starting_point": "lagankhel",
    "final_point": "ratnapark",
    "stops": ["kumaripati", "pulchowk", "kupondole", "maitighar"],
    "vehicle": 3
  }
];
List<Map<String, Object>> vehicle = [
  {"id": 1, "name": "Sajha Bus", "type": "bus"},
  {"id": 2, "name": "Tempo", "type": "tempo"},
  {"id": 3, "name": "Nepal Yatayat", "type": "bus"},
  {"id": 4, "name": "Micro Bus", "type": "microbus"},
  {"id": 5, "name": "Nepal Yatayat", "type": "bus"}
];

String jsonString = json.encode(jsonVehicle);

class MyLogic {
  String startingPoint;
  String destination;

  MyLogic({required this.startingPoint, required this.destination});

  List<dynamic> search() {
    dynamic data = jsonDecode(jsonString);
    List<dynamic> route = [];
    List<dynamic> results = [];
    for (var vehicle in data['vehicles']) {
      for (var fare in vehicle['fares']) {
        if (fare['start_location']
                .toLowerCase()
                .contains(startingPoint.toLowerCase()) &&
            fare['end_location']
                .toLowerCase()
                .contains(destination.toLowerCase())) {
          results.add(fare);
          route.add(fare['route']);
          break;
        }
      }
    }
    return route;
  }

  void filter() {
    // code for filtering
  }

  List<String> finalRoutes() {
    // code for generating final routes
    return ['Route 1', 'Route 2', 'Route 3'];
  }
}

void main(List<String> args) {
  MyLogic logic = MyLogic(startingPoint: 'A', destination: 'F');

  dynamic searchedObject = logic.search();
  var searchedvehicle = [];
  var searchedlist = [];

  for (var id in searchedObject) {
    searchedvehicle.add(jsonRoute[id]["vehicle"]);
    // print('vehicle: ' + jsonRoute[id]["vehicle"]);
  }
  for (var id in searchedvehicle) {
    searchedlist.add(vehicle[id]["name"]);
    print(vehicle[id]["name"]);
  }
}
