import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _confirmPasswordontroller = TextEditingController();

  bool isChecked = false;
  String selectedRole = 'user';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _fullnameController.dispose();
    _confirmPasswordontroller.dispose();
    super.dispose();
  }

  void signUp() async {
    try {
      if (_passwordController.text == _confirmPasswordontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "fullname": _fullnameController.text,
          "username": _usernameController.text,
          "email": FirebaseAuth.instance.currentUser!.email,
          "uid": FirebaseAuth.instance.currentUser!.uid,
          "role": selectedRole
        });
      } else {
        showErrorMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message);
    }
  }

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
        child: Column(children: [
          SizedBox(
            height: 150,
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
                        child: Text("Hi ! ",
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
                        child: Text("Welcome",
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
          Text(
              "Let's create an account                                       "),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(hintText: "Email"),
              controller: _emailController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(hintText: "Full name"),
              controller: _fullnameController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: InputDecoration(hintText: "Username"),
              controller: _usernameController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
              controller: _passwordController,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: "Confirm password"),
              controller: _confirmPasswordontroller,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Your Role:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                items: <String>['user', 'admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: signUp,
              child: Text(
                "Sign Up",
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text("Dont have an account ?"),
              ),
              TextButton(
                  onPressed: widget.onTap,
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
