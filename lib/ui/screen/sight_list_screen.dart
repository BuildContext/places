import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

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
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              "Список интересных мест",
              style: TextStyle(
                color: Color(0xff3B3E5B),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
            ),
          ),
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SightCard(
                sight: mocks[1],
              ),
              SightCard(
                sight: mocks[2],
              ),
              SightCard(
                sight: mocks[0],
              ),
            ],
          ),
        ));
  }
}
