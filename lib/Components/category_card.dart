import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final Color background;
  final String title;
  final Icon icon;
  final Function()? onTap;

  CategoryCard({
    Key? key,
    required this.background,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(55, 50, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
              color: Colors.brown.shade200,
            ),
            child: IconButton(
              icon: icon,
              iconSize: 70,
              onPressed: onTap,
            ),
            width: 120,
            height: 120,
          ),
          Container(
              alignment: Alignment.topCenter,
              width: 120,
              height: 20,
              child: Text(
                title,
                style: GoogleFonts.poppins(),
              )),
        ],
      ),
    );
  }
}
