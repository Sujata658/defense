import 'package:flutter/material.dart';
import '../passenger/routedesc.dart';

class HorizontalPlaceItem extends StatelessWidget {
  HorizontalPlaceItem({Key? key, required this.place, required this.Sheight})
      : super(key: key);
  final Map place;
  dynamic Sheight;
  late int id;

  @override
  Widget build(BuildContext context) {
    var Swidth = MediaQuery.of(context).size.width / 3;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        child: Container(
          height: Sheight,
          width: Swidth-20,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "${place["img"]}",
                  height: (71 / 100) * Sheight,
                  width:Swidth,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place["location"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.blueGrey[300],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          id = place['id'];
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details(id: id - 1);
              },
            ),
          );
        },
      ),
    );
  }
}
