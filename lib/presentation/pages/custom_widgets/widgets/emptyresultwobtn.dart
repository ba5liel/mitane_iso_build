import 'package:flutter/material.dart';

class EmptyResultWBtn extends StatelessWidget {
  final String title;
  final String description;
  const EmptyResultWBtn({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width * .6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/ufo (1).png"))),
            ),
          ),
          SizedBox(height: 35),
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          SizedBox(height: 12),
          Container(
            width: 200,
            child: Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
          Spacer(flex: 1)
        ],
      ),
    );
  }
}
