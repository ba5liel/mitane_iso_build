import 'package:flutter/material.dart';

class EmptyResult extends StatelessWidget {
  final String title;
  final String description;
  final String btntxt;
  final Function onTap;
  const EmptyResult({
    Key? key,
    required this.title,
    required this.description,
    required this.btntxt,
    required this.onTap,
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
                  color: Colors.white)),
          SizedBox(height: 12),
          Container(
            width: 200,
            child: Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () => onTap(),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xDD8CC63E)),
                child: Text(
                  btntxt,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Spacer(flex: 1)
        ],
      ),
    );
  }
}
