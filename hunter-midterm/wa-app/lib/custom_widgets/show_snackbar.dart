import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSnackBar{
  static showSnackBar({required BuildContext context,required String title}){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.black54,
        content: Text(title,style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),),
      ),
    );
  }
}