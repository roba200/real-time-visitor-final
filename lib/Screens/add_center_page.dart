import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCenterPage extends StatefulWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _totalParkingController = TextEditingController();
  String _category = "resturants";

  AddCenterPage({super.key});

  @override
  State<AddCenterPage> createState() => _AddCenterPageState();
}

class _AddCenterPageState extends State<AddCenterPage> {
  @override
  void dispose() {
    widget._imageUrlController.dispose();
    widget._nameController.dispose();
    widget._totalParkingController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add a Center',
              style: GoogleFonts.poppins(fontSize: 50),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: widget._nameController,
                decoration: InputDecoration(
                    hintText: "Name", hintStyle: GoogleFonts.poppins()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: widget._imageUrlController,
                decoration: InputDecoration(
                    hintText: "Image Url", hintStyle: GoogleFonts.poppins()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: widget._totalParkingController,
                decoration: InputDecoration(
                    hintText: "Total Parking",
                    hintStyle: GoogleFonts.poppins()),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Selected Category: ',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            SizedBox(height: 2),
            DropdownButton<String>(
              value: widget._category,
              onChanged: (String? newValue) {
                setState(() {
                  widget._category = newValue!;
                });
              },
              items: <String>[
                'cafes',
                'cinemas',
                'malls',
                'museums',
                'resturants',
                'supermarkets',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (widget._nameController.text.isNotEmpty &&
                      widget._imageUrlController.text.isNotEmpty &&
                      widget._totalParkingController.text.isNotEmpty) {
                    CollectionReference collectionRef =
                        FirebaseFirestore.instance.collection(widget._category);
                    DocumentReference documentRef = await collectionRef.add({
                      'name': widget._nameController.text,
                      'available_parking': 0,
                      'capacity': "0",
                      'image_url': widget._imageUrlController.text,
                      'down': 0,
                      'name_lowercase':
                          widget._nameController.text.toLowerCase(),
                      'owner_id': FirebaseAuth.instance.currentUser!.uid,
                      'total_parking': 0,
                      'up': 0
                    });
                    String docId = documentRef.id;
                    await documentRef.update({'uid': docId});

                    FirebaseFirestore.instance
                        .collection('centers')
                        .doc(docId)
                        .set({
                      'image_url': widget._imageUrlController.text,
                      'uid': docId,
                      'name': widget._nameController.text,
                      'name_lowercase':
                          widget._nameController.text.toLowerCase(),
                      'owner_id': FirebaseAuth.instance.currentUser!.uid,
                      'january_visitors': 0,
                      'february_visitors': 0,
                      'march_visitors': 0,
                      'april_visitors': 0,
                      'may_visitors': 0,
                      'june_visitors': 0,
                      'july_visitors': 0,
                      'august_visitors': 0,
                      'september_visitors': 0,
                      'october_visitors': 0,
                      'november_visitors': 0,
                      'december_visitors': 0,
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Center Added Successfully!")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please Fill the Fields")));
                  }
                },
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
