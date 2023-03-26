import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasarijaane/components/constants.dart';
import 'package:kasarijaane/searchresult.dart';

List<Color> colors = [ktheme, kdarkblue, Colors.grey];

class Timeline extends StatefulWidget {
  Timeline({
    Key? key,
    required this.processCard,
    required this.start,
    required this.end,
  }) : super(key: key);

  final List<dynamic> processCard;
  final String start;
  final String end;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    final processCard = widget.processCard;
    List<dynamic> newprocessCard = [];

    // Copy relevant elements from processCard to newprocessCard
    var startNodeReached = false;
    var endNodeReached = false;
    for (var onecard in processCard) {
      if (onecard == widget.start) {
        startNodeReached = true;
      }
      if (startNodeReached) {
        newprocessCard.add(onecard);
      }
      if (onecard == widget.end) {
        endNodeReached = true;
        break;
      }
    }

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: newprocessCard.length,
              itemBuilder: (context, newIndex) {
                return Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 2,
                              height: 10,
                              color: newIndex == 0 ? kwhite : colors[1],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colors[0],
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 10,
                              color: newIndex == (newprocessCard.length - 1)
                                  ? kwhite
                                  : colors[1],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          newprocessCard[newIndex],
                          style: TextStyle(
                            fontSize: 12,
                            color: colors[0],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
