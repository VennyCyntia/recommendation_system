import 'package:flutter/material.dart';

class ThemeConfig {
  static const justBlack = Color.fromRGBO(27, 35, 38, 1);
  static const lightBlack = Color.fromRGBO(43, 51, 56, 1.0);
  static const justGrey = Color.fromRGBO(210, 210, 210, 1.0);
  static const justBlue = Color.fromRGBO(228, 249, 255, 1.0);
  static const justGreen = Color.fromRGBO(16, 245, 204, 1);
  static const justWhite = Color.fromRGBO(245, 254, 253, 1);
  static const darkRed = Color.fromRGBO(208, 56, 70, 1);
  static const justRed = Color.fromRGBO(210, 0, 1, 1);
  static const baseRed = Color.fromRGBO(255, 64, 85, 1.0);
  static const lightRed = Color.fromRGBO(236, 50, 53, 1.0);
  static const darkBlue = Color.fromRGBO(3, 54, 220, 1.0);
  static const lightGrey = Color.fromRGBO(192, 192, 192, 1.0);
  static const baseGrey = Color.fromRGBO(203, 203, 203, 1.0);
  static const transparant = Color.fromRGBO(192, 192, 192, 1.0);
  static const lightBlue = Color.fromRGBO(11, 210, 190, 1.0);
  static const sourcingRed = Color.fromRGBO(210, 0, 0, 1);

  double defaultFormHeight = 55.0; //default form text height
  double minSpacing = 4.0;
  double defaultSpacing = 8.0;
  double biggerSpacing = 12.0;
  double extraSpacing = 16.0;
  double extra2Spacing = 30.0;

  onUnfocuseNode(){
    if(FocusManager.instance.primaryFocus?.hasPrimaryFocus != null ||
        FocusManager.instance.primaryFocus?.hasFocus != null){
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  BoxShadow onSetDefaultShadow() {
    return BoxShadow(
        color: Colors.grey.withOpacity(0.14),
        blurRadius: 3,
        spreadRadius: 0.5,
        offset: const Offset(0, 2));
  }

  TextStyle textHeaderBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader1Bold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader2Bold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeadermidBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader3Bold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 18.72,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
    return text;
  }

  TextStyle textHeader4Bold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader5Bold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader6Bold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeaderMid({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 14,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader1Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader2Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader3Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 18.72,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader4Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 15,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader5Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 13.5,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader6Thin({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader1({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 32,
    );
    return text;
  }

  TextStyle textHeader2({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 24,
    );
    return text;
  }

  TextStyle textHeader3({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 18.72,
    );
    return text;
  }

  TextStyle textHeader4({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 16,
    );
    return text;
  }

  TextStyle textHeader5({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 13.28,
    );
    return text;
  }

  TextStyle textHeader6({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 12,
    );
    return text;
  }

  TextStyle textExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle text1ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle text2ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w700
    );
    return text;
  }

  TextStyle textHeader1ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader2ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader3ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    return text;
  }

  TextStyle textHeader4ExtraBold({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins'
    );
    return text;
  }

  TextStyle textHeader2BoldItalic({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontStyle: FontStyle.italic
    );
    return text;
  }

  TextStyle textHeaderBoldItalic({required Color color}) {
    TextStyle text = TextStyle(
        color: color,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        fontStyle: FontStyle.italic
    );
    return text;
  }

  TextStyle textHeader3BoldWordSpacing({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 18.72,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      letterSpacing: 4.0,
      wordSpacing: 7.0,
    );
    return text;
  }

  TextStyle textHeader3ExtraBoldSpacing({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins',
      letterSpacing: 1.5,
    );
    return text;
  }

  TextStyle textHeader4BoldSpacing({required Color color}) {
    TextStyle text = TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      letterSpacing: 1.5,
    );
    return text;
  }

}