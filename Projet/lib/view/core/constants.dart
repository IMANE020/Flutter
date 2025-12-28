import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors
const blackColor = Colors.black;
const blackClr45 = Colors.black45;
const whiteColor = Colors.white;
const whiteClr24 = Colors.white24;
const greyColor = Colors.grey;
const blueColor = Colors.blue;
final blueClr300 = Colors.blue[300];
final blueClr100 = Colors.blue[100];
final greyClr300 = Colors.grey[800];
final greyClr600 = Colors.grey[600];

// Premium TextStyles
final whiteTxt14 = GoogleFonts.outfit(color: Colors.white, fontSize: 14);
final whiteTxt18 = GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
final whiteTxt20 = GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
final whiteTxt22 = GoogleFonts.outfit(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
final white38Txt14 = GoogleFonts.outfit(color: Colors.white38, fontSize: 14);
final cyanTxt60 = GoogleFonts.outfit(color: Colors.cyan[100], fontSize: 80, fontWeight: FontWeight.w100);
final splashTxtStyle = GoogleFonts.outfit(
  color: whiteColor,
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2
);

// Light Theme Colors
const lightBgColor = Color(0xFFB8D7EB); // More darker blueish background
const cardColor = Colors.white;
const primaryText = Color(0xFF202020);
const secondaryText = Color(0xFF707070);

// Dark TextStyles (for light theme)
final darkTxt14 = GoogleFonts.outfit(color: primaryText, fontSize: 14);
final darkTxt16 = GoogleFonts.outfit(color: primaryText, fontSize: 16, fontWeight: FontWeight.w500);
final darkTxt18 = GoogleFonts.outfit(color: primaryText, fontSize: 18, fontWeight: FontWeight.w600);
final darkTxt22 = GoogleFonts.outfit(color: primaryText, fontSize: 22, fontWeight: FontWeight.bold);
final darkTxt60 = GoogleFonts.outfit(color: primaryText, fontSize: 80, fontWeight: FontWeight.bold);
final greyTxt14 = GoogleFonts.outfit(color: secondaryText, fontSize: 14);

// Card Decoration
final cardDecoration = BoxDecoration(
  color: cardColor,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 20,
      offset: Offset(0, 5),
    )
  ]
);

// Glassmorphism Decoration (keeping for reference but might not use)
final glassDecoration = BoxDecoration(
  color: Colors.white.withOpacity(0.1),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: Colors.white.withOpacity(0.2)),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 1,
    )
  ]
);

// Height and Width
const sbHeight10 = SizedBox(height: 10);
const sbHeight20 = SizedBox(height: 20);
const sbHeight30 = SizedBox(height: 30);
const sbWidth10 = SizedBox(width: 10);
