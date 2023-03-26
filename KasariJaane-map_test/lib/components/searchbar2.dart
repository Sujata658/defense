import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constants.dart';
import '../searchresult.dart';

class SearchBar2 extends StatelessWidget {
  SearchBar2({Key? key, required this.label, required this.controller})
      : super(key: key);
  String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kwhite,
        border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.my_location,
            color: kdarkblue,
          ),
          hintText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16.0),
          // suffixIcon: Icon(
          //   Icons.tune,
          //   color: kdarkpurple,
          // ),
        ),
      ),
    );
  }
}
