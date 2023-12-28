import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableParkingPage extends StatefulWidget {
  final String category;
  final String uid;
  AvailableParkingPage({super.key, required this.category, required this.uid});

  @override
  State<AvailableParkingPage> createState() => _AvailableParkingPageState();
}

class _AvailableParkingPageState extends State<AvailableParkingPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            gradient: LinearGradient(colors: [Colors.orange, Colors.yellow]),
          ),
          height: screenhight * 0.25,
          child: Container(
            child: Column(children: [
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "Available Parking",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )),
            ]),
          ),
        ),
        SizedBox(
          height: 150,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(widget.category)
                .doc(widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!['available_parking'].toString() +
                      " / " +
                      snapshot.data!['total_parking'].toString(),
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
      ]),
    );
  }
}
