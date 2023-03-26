import 'package:flutter/material.dart';
import 'package:kasarijaane/api_service.dart';
import 'package:kasarijaane/model/route_model.dart';
import 'package:kasarijaane/offline/route.dart';
import '../components/footer.dart';
import '../components/constants.dart';
import '../components/searchbar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      appBar: AppBar(title: Text('Found routes')),
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(label: 'Search for result'),
            OtherElements(),
          ],
        ),
      ),
    );
  }
}

class OtherElements extends StatefulWidget {
  OtherElements({Key? key}) : super(key: key);

  @override
  State<OtherElements> createState() => _OtherElementsState();
}

class _OtherElementsState extends State<OtherElements> {
  RouteModel? routeModel;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return routeModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Expanded(
            child: ListView.builder(
                // itemCount: routeModel!.length,
                itemBuilder: (BuildContext context, int index) {
              String vehicle1 = routeModel!.vehicles[0].name;
              String fare1 = routeModel!.vehicles[0].fares[0].fare;
              print(vehicle1);
              print(fare1);
              return ListTile(
                leading: Icon(Icons.location_on),
                title: Text('vehicle'),
                subtitle: Text('Fare '),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage("https://picsum.photos/100"),
                ),
              );
            }),
          );
  }
} // <-- Add this closing br
