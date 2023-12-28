import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visitor_counting_system/Components/category_card.dart';
import 'package:visitor_counting_system/Components/center_card.dart';
import 'package:visitor_counting_system/Screens/add_center_page.dart';
import 'package:visitor_counting_system/Screens/dashboard_page.dart';
import 'package:visitor_counting_system/Screens/details_page.dart';

class AdminShopsPage extends StatefulWidget {
  const AdminShopsPage({super.key});

  @override
  State<AdminShopsPage> createState() => _AdminShopsPageState();
}

class _AdminShopsPageState extends State<AdminShopsPage> {
  String searchText = "";
  Future<void> refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCenterPage()));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.orange, Colors.yellow]),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
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
                                FirebaseAuth.instance.signOut();
                              },
                              icon: Icon(Icons.exit_to_app)),
                        ),
                        Container(
                            width: screenWidth * 0.75,
                            child: SearchBar(
                              onChanged: (text) {
                                setState(() {
                                  searchText = text.toLowerCase();
                                  print(searchText);
                                });
                              },
                              hintText: "Search",
                              leading: Icon(Icons.search),
                            )),
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
                                  "Your Centers",
                                  style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                  ]),
                ),
              ),
              Container(
                height: screenhight * 0.75,
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('centers')
                          .where('owner_id',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CenterCard(
                                  image: snapshot.data!.docs[index]
                                      ['image_url'],
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DashboardPage(
                                                  centeer_id: snapshot
                                                      .data!.docs[index]['uid'],
                                                )));
                                  },
                                  title: snapshot.data!.docs[index]['name'],
                                ),
                              );
                            });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
