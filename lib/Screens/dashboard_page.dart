import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Bar_Graph/bar_graph.dart';

class DashboardPage extends StatefulWidget {
  final String centeer_id;
  const DashboardPage({super.key, required this.centeer_id});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<int> monthlyVisitors = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  Future fetchData() async {
    // Replace 'your_collection' with the actual collection name in Firestore
    var snapshot = await FirebaseFirestore.instance
        .collection('centers')
        .doc(widget.centeer_id)
        .get();

    if (snapshot.exists) {
      monthlyVisitors = [
        snapshot.get('january_visitors'),
        snapshot.get('february_visitors'),
        snapshot.get('march_visitors'),
        snapshot.get('april_visitors'),
        snapshot.get('may_visitors'),
        snapshot.get('june_visitors'),
        snapshot.get('july_visitors'),
        snapshot.get('august_visitors'),
        snapshot.get('september_visitors'),
        snapshot.get('october_visitors'),
        snapshot.get('november_visitors'),
        snapshot.get('december_visitors'),
      ];
      print(monthlyVisitors);

      return snapshot;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visitors Summery",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Center(
          child: SizedBox(
              height: 400,
              child: FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return MyBarGraph(
                        monthlySummary: monthlyVisitors,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))),
    );
  }
}
