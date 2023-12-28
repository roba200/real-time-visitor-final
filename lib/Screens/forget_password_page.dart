import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool isChecked = false;

  TextEditingController _emailController = TextEditingController();

  void showErrorMessage(String? message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 220,
          ),
          Container(
            height: 150,
            child: Stack(
              children: [
                Positioned(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text("Oh,no ! ",
                            style: GoogleFonts.poppins(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text("I forgot",
                            style: GoogleFonts.poppins(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Enter your email,phone or username and we'll send you a link to change a new password",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Reset Link Send to " + _emailController.text)));
                } on FirebaseAuthException catch (e) {
                  showErrorMessage(e.message);
                }
              },
              child: Text(
                "Forget Password",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(screenWidth * 0.82, screenhight * 0.06),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)))),
          SizedBox(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text("Dont have an account ?"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
