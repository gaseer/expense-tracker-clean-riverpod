import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppTheme {
  static const commonBgColor = Color(0xff151617);
  static const secondaryTextColor = Color(0xffCFCFCF);
  static const darkTextColor = Color(0xff959595);
  static const commonBorderColor = Color(0xff424242);
  static const whiteSnack = Color(0xFFF8F9FD);
  static const commonColor = Color(0xffFC8118);

  static const errorColor = Colors.red;
  static const orangeee = Color(0xffFC8118);
  static const Color darkCardColor = Color(0xff242629);

  static ButtonStyle commonButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(width: 1.4, color: Colors.white),
      ),
      minimumSize: const Size(double.infinity, 40),
      backgroundColor: Colors.redAccent.withOpacity(.55));

  static TextStyle formTextStyle = const TextStyle(
    color: Color(0xff959595),
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static BoxDecoration commonGradientBackgroundDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF151617),
        Color(0xFF212326),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static TextStyle commonFontStyle(
      {double? size, Color? color, FontWeight? weight}) {
    return TextStyle(
        fontSize: size ?? 15,
        color: color ?? Colors.white,
        fontWeight: weight ?? FontWeight.w600);
  }
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.redAccent,
    hintColor: Colors.redAccent.withOpacity(.5),
    scaffoldBackgroundColor: gray,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: gray70.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: gray40),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppTheme.errorColor),
      ),
      errorStyle: const TextStyle(color: Colors.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.white54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: secondary50),
      ),
      labelStyle: const TextStyle(color: Colors.white),
      hintStyle: const TextStyle(color: Colors.white),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.transparent,
      selectionHandleColor: secondary50,
    ),
    datePickerTheme: DatePickerThemeData(
      rangeSelectionBackgroundColor: Colors.redAccent,
      dayStyle: TextStyle(color: Colors.redAccent),
      backgroundColor: gray, // Background of the date picker
      // Picker header style
      headerHeadlineStyle: TextStyle(
          color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.w600),
      elevation: 10, // Elevation of the picker
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Rounded corners for the picker
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      scrolledUnderElevation: 0,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Roboto', // Set the font family globally
      ),
      bodyMedium: TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontFamily: 'Roboto',
      ),
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: Colors.white70,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orangeAccent, // Button background color
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent, // Text color for the elevated button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white70, // Default icon color
    ),
    dividerColor: Colors.white30,
    cardColor: const Color(0xFF1E1E1E),
    cardTheme: const CardTheme(
      color: Color(0xFF1E1E1E),
      elevation: 5,
      margin: EdgeInsets.all(8),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white54,
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );
}
