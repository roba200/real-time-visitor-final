import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Components/category_card.dart';
import 'package:visitor_counting_system/Components/center_card.dart';
import 'package:visitor_counting_system/Screens/details_page.dart';

class CinemaPage extends StatefulWidget {
  const CinemaPage({super.key});

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  String searchText = "";
  Future<void> refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                        ),
                        Container(
                            width: screenWidth * 0.75,
                            child: SearchBar(
                              hintText: "Search",
                              leading: Icon(Icons.search),
                              onChanged: (text) {
                                setState(() {
                                  searchText = text.toLowerCase();
                                  print(searchText);
                                });
                              },
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
                                  "Cinemas",
                                  style: TextStyle(
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
                child: StreamBuilder(
                    stream: searchText.isNotEmpty
                        ? FirebaseFirestore.instance
                            .collection('cinemas')
                            .where('name_lowercase',
                                isGreaterThanOrEqualTo: searchText)
                            .where('name_lowercase',
                                isLessThanOrEqualTo: searchText + '\uf8ff')
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('cinemas')
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: refresh,
                        child: GridView.builder(
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
                                            builder: (context) => DetailsPage(
                                                  uid: snapshot
                                                      .data!.docs[index]['uid'],
                                                  imageUrl: snapshot.data!
                                                      .docs[index]['image_url'],
                                                  name: snapshot.data!
                                                      .docs[index]['name'],
                                                  category: 'cinemas',
                                                )));
                                  },
                                  title: snapshot.data!.docs[index]['name'],
                                ),
                              );
                            }),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
