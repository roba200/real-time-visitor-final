import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterCard extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;
  CenterCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.amber[400],
                ),
                Text(
                  " 5.0 (770K)",
                  style: GoogleFonts.poppins(),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.location_pin,
                  size: 15,
                  color: Colors.grey[400],
                ),
                Text(
                  " 5Km",
                  style: GoogleFonts.poppins(),
                ),
              ],
            )
          ],
        ));
  }
}
