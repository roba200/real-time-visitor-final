import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitor_counting_system/Screens/forget_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isChecked = false;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: screenhight * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",
                  style: GoogleFonts.poppins(
                      fontSize: 65, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10.0),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ))
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                await signIn();
              },
              child: Text(
                "Log in",
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
          // TextButton(
          //     onPressed: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text("Not implemented yet!")));
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 20.0),
          //       child: Text(
          //         "Continue with Google",
          //         style: TextStyle(color: Colors.black87, fontSize: 16),
          //       ),
          //     )),
          SizedBox(
            height: 110,
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
                    "Sign Up",
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
