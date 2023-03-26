import 'package:flutter/material.dart';

import 'components/constants.dart';

class VehicleDesc extends StatelessWidget {
  final dynamic vehicles;

  const VehicleDesc(this.vehicles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kdarkpurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(''),
        automaticallyImplyLeading: true,
        elevation: 0.0,
      ),
      backgroundColor: kgrey,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${vehicles.name}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Route: ${vehicles.icon}',
              style: TextStyle(fontSize: 16.0),
            ),
           
          ],
        ),
      ),
    );
  }
}
