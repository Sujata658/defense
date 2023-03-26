import 'package:flutter/material.dart';
import '../components/constants.dart';
import '../components/footer.dart';
import '../components/searchbar.dart';
import '../othercomp/horizontallist.dart';
import '../utils/places.dart';
import 'package:kasarijaane/model/vehicletype_model.dart';
import 'package:kasarijaane/model/exploreplaces_model.dart';
import 'package:kasarijaane/api_service.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<VehicleTypesModel>? vehicletype = [];
  late List<ExplorePlacesModel>? exploreplace = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    vehicletype = await (VehicleTypeService().getVehicleTypes());
    exploreplace = await (ExplorePlacesService().getExplorePlaces());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Explore',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                buildHorizontalList(context, "places", 210.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Vehicles',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                buildHorizontalList(context, "vehicles", 150.0),
                SizedBox(
                  height: 20.0,
                ),
                SearchBar(label: "Search for pickup"),
                SizedBox(
                  height: 10.0,
                ),
                SearchBar(label: "Search for destination"),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildHorizontalList(BuildContext context, String type, var height) {
    // Choose the data to display based on the value of type
    List<dynamic> data = [];
    if (type == 'vehicles') {
      List<VehicleTypesModel>? data = vehicletype!;
      print(vehicletype);
    } else if (type == 'places') {
      List<ExplorePlacesModel>? data = exploreplace!;
      print(data);
    }

    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Map item = data.reversed.toList()[index];
          if (type == 'vehicles') {
            return HorizontalPlaceItem(place: item, Sheight: height);
          } else if (type == 'places') {
            return HorizontalPlaceItem(place: item, Sheight: height);
          }
          return Container(); // fallback if type is unknown
        },
      ),
    );
  }
}
