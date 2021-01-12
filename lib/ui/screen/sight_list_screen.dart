import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 44),
          child: RichText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: TextSpan(
              text:"С",
              style: TextStyle(
                color: Color(0xff4CAF50),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: "писок ",
                  style: TextStyle(
                    color: Color(0xff3B3E5B)
                  ),
                  children: [
                    TextSpan(
                      text: "и",
                      style: TextStyle(
                        color: Color(0xffFCDD3D)
                      ),
                      children: [
                        TextSpan(
                          text: "нтересных мест",
                          style: TextStyle(
                              color: Color(0xff3B3E5B)
                          ),
                        )
                      ]
                    )
                  ]
                )
              ]
            ),
          ),
        ),
        toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        elevation: 0,
      )
    );
  }
}
