import 'package:flutter/material.dart';
import 'package:kasarijaane/passenger/result.dart';
import 'constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.label}) : super(key: key);
  String label;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kwhite,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: kdarkpurple,
          ),
          hintText: widget.label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16.0),
          suffixIcon: Icon(
            Icons.tune,
            color: kdarkpurple,
          ),
        ),
        onSubmitted: (query) {
          setState(() {
            _query = query;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultPage(query: _query,)),
            );
          });
        },
      ),
    );
  }
}
