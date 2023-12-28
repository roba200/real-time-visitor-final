import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitor_counting_system/Screens/admin_shops_page.dart';
import 'package:visitor_counting_system/Screens/category_page.dart';
import 'package:visitor_counting_system/Screens/dashboard_page.dart';
import 'package:visitor_counting_system/Screens/login_or_sign_up_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? user = snapshot.data;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                // Check the user's role and navigate accordingly
                String? role = snapshot.data?.get('role');
                if (role == 'admin') {
                  return AdminShopsPage();
                } else {
                  return CategoryPage();
                }
              },
            );
          } else {
            return LoginOrSignUpPage();
          }
        },
      ),
    );
  }
}
