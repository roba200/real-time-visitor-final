import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Screens/available_parking_page.dart';

class DetailsPage extends StatefulWidget {
  final String uid;
  final String imageUrl;
  final String name;
  final String category;
  const DetailsPage(
      {super.key,
      required this.uid,
      required this.imageUrl,
      required this.name,
      required this.category});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(widget.category)
              .doc(widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: screenWidth,
                        child: Image.network(
                          widget.imageUrl,
                        )),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(Icons.star),
                        Text(" 5.0 "),
                        Text("(770K)"),
                        SizedBox(width: 10),
                        Icon(Icons.location_pin),
                        Text("5Km")
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Visitors : " +
                                (snapshot.data!['down'] - snapshot.data!['up'])
                                    .toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                                "Capacity : " + snapshot.data!['capacity']),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Icon(
                        Icons.location_pin,
                        size: 40,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Location",
                        style: TextStyle(fontSize: 17),
                      ),
                    ]),
                    SizedBox(height: 320),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AvailableParkingPage(
                                        category: widget.category,
                                        uid: widget.uid,
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See available parking",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
