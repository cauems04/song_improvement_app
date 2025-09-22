import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Color.fromRGBO(112, 82, 183, 1),
    onPrimary: Color.fromRGBO(194, 170, 251, 1),
    primaryContainer: Color.fromRGBO(14, 0, 47, 1),

    surface: Color.fromRGBO(14, 14, 14, 1),
    surfaceContainerLowest: Color.fromRGBO(31, 31, 36, 1),
    surfaceContainerLow: Color.fromRGBO(109, 111, 118, 1),
    surfaceContainer: Color.fromRGBO(152, 153, 158, 1),
    surfaceContainerHigh: Color.fromRGBO(197, 197, 199, 1),
    surfaceContainerHighest: Color.fromRGBO(240, 240, 240, 1),

    error: Color.fromRGBO(135, 11, 17, 1),
    onError: Color.fromRGBO(237, 56, 65, 1),
  ),

  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.normal,
    ),
  ),
);

// DarkTheme darkTheme = DarkTheme(
  // primaryColor: PrimaryColor(
  //   primaryColorDarkest: Color.fromRGBO(14, 0, 47, 1),
  //   primaryColorDark: Color.fromRGBO(52, 26, 115, 1),
  //   primaryColorMedium: Color.fromRGBO(112, 82, 183, 1),
  //   primaryColorLight: Color.fromRGBO(194, 170, 251, 1),
  //   primaryColorLightest: Color.fromRGBO(214, 197, 255, 1),
  // ),
  // basicColor: BasicColor(
  //   basicColorDarkest: Color.fromRGBO(14, 14, 14, 1),
  //   basicColorDark: Color.fromRGBO(31, 31, 36, 1),
  //   basicColorMedium: Color.fromRGBO(69, 70, 77, 1),
  //   basicColorLight: Color.fromRGBO(109, 111, 118, 1),
  //   basicColorLighter: Color.fromRGBO(152, 153, 158, 1),
  //   basicColorLightest: Color.fromRGBO(240, 240, 240, 1),
  // ),
  // successColor: SuccessColor(
  //   successColorDarkest: Color.fromRGBO(18, 79, 60, 1),
  //   successColorDark: Color.fromRGBO(41, 130, 103, 1),
  //   successColorMedium: Color.fromRGBO(73, 181, 148, 1),
  //   successColorLight: Color.fromRGBO(115, 232, 197, 1),
  // ),
  // alertColor: AlertColor(
  //   alertColorDarkest: Color.fromRGBO(79, 19, 1, 1),
  //   alertColorDark: Color.fromRGBO(130, 40, 11, 1),
  //   alertColorMedium: Color.fromRGBO(181, 66, 30, 1),
  //   alertColorLight: Color.fromRGBO(232, 99, 57, 1),
  // ),
  // errorColor: ErrorColor(
  //   errorColorDarkest: Color.fromRGBO(84, 0, 4, 1),
  //   errorColorDark: Color.fromRGBO(135, 11, 17, 1),
  //   errorColorMedium: Color.fromRGBO(186, 29, 37, 1),
  //   errorColorLight: Color.fromRGBO(237, 56, 65, 1),
  // ),
  // headerStyles: HeaderStyles(
  //   h1: TextStyle(
  //     color: Colors.white,
  //     fontSize: 24,
  //     fontWeight: FontWeight.w600,
  //     letterSpacing: 1.2,
  //   ),
  //   h2: TextStyle(
  //     color: Colors.white,
  //     fontSize: 22,
  //     fontWeight: FontWeight.w600,
  //     letterSpacing: 1.2,
  //   ),
  //   h3: TextStyle(
  //     color: Colors.white,
  //     fontSize: 18,
  //     fontWeight: FontWeight.w600,
  //     letterSpacing: 1.2,
  //   ),
  //   h4: TextStyle(
  //     color: Colors.white,
  //     fontSize: 16,
  //     fontWeight: FontWeight.normal,
  //     letterSpacing: 1.2,
  //   ),
  // ),
  // bodyStyles: BodyStyles(
  //   b1: TextStyle(
  //     color: Colors.white,
  //     fontSize: 14,
  //     fontWeight: FontWeight.normal,
  //     letterSpacing: 1.5,
  //   ),
  //   b2: TextStyle(
  //     color: Colors.white,
  //     fontSize: 12,
  //     fontWeight: FontWeight.normal,
  //     letterSpacing: 1.5,
  //   ),
  //   b3: TextStyle(
  //     color: Colors.white,
  //     fontSize: 10,
  //     fontWeight: FontWeight.normal,
  //     letterSpacing: 1.5,
  //   ),
  // ),
// );

// @immutable
// class DarkTheme extends ThemeExtension<DarkTheme> {
//   final PrimaryColor primaryColor;
//   final BasicColor basicColor;
//   final SuccessColor successColor;
//   final AlertColor alertColor;
//   final ErrorColor errorColor;
//   final HeaderStyles headerStyles;
//   final BodyStyles bodyStyles;
//   final Spacing spacing;

//   const DarkTheme({
//     required this.primaryColor,
//     required this.basicColor,
//     required this.successColor,
//     required this.alertColor,
//     required this.errorColor,
//     required this.headerStyles,
//     required this.bodyStyles,
//     required this.spacing,
//   });

//   @override
//   DarkTheme copyWith({
//     PrimaryColor? primaryColor,
//     BasicColor? basicColor,
//     SuccessColor? successColor,
//     AlertColor? alertColor,
//     ErrorColor? errorColor,
//     HeaderStyles? headerStyles,
//     BodyStyles? bodyStyles,
//     Spacing? spacing,
//   }) {
//     return DarkTheme(
//       primaryColor: primaryColor ?? this.primaryColor,
//       basicColor: basicColor ?? this.basicColor,
//       successColor: successColor ?? this.successColor,
//       alertColor: alertColor ?? this.alertColor,
//       errorColor: errorColor ?? this.errorColor,
//       headerStyles: headerStyles ?? this.headerStyles,
//       bodyStyles: bodyStyles ?? this.bodyStyles,
//       spacing: spacing ?? this.spacing,
//     );
//   }

//   @override
//   DarkTheme lerp(ThemeExtension<DarkTheme>? other, double t) {
//     if (other is! DarkTheme) return this;

//     Color lerpColor(Color a, Color b) => Color.lerp(a, b, t)!;
//     TextStyle lerpTextStyle(TextStyle a, TextStyle b) =>
//         TextStyle.lerp(a, b, t)!;

//     return DarkTheme(
//       primaryColor: PrimaryColor(
//         primaryColorDarkest: lerpColor(
//           primaryColor.primaryColorDarkest,
//           other.primaryColor.primaryColorDarkest,
//         ),
//         primaryColorDark: lerpColor(
//           primaryColor.primaryColorDark,
//           other.primaryColor.primaryColorDark,
//         ),
//         primaryColorMedium: lerpColor(
//           primaryColor.primaryColorMedium,
//           other.primaryColor.primaryColorMedium,
//         ),
//         primaryColorLight: lerpColor(
//           primaryColor.primaryColorLight,
//           other.primaryColor.primaryColorLight,
//         ),
//         primaryColorLightest: lerpColor(
//           primaryColor.primaryColorLightest,
//           other.primaryColor.primaryColorLightest,
//         ),
//       ),
//       basicColor: BasicColor(
//         basicColorDarkest: lerpColor(
//           basicColor.basicColorDarkest,
//           other.basicColor.basicColorDarkest,
//         ),
//         basicColorDark: lerpColor(
//           basicColor.basicColorDark,
//           other.basicColor.basicColorDark,
//         ),
//         basicColorMedium: lerpColor(
//           basicColor.basicColorMedium,
//           other.basicColor.basicColorMedium,
//         ),
//         basicColorLight: lerpColor(
//           basicColor.basicColorLight,
//           other.basicColor.basicColorLight,
//         ),
//         basicColorLighter: lerpColor(
//           basicColor.basicColorLighter,
//           other.basicColor.basicColorLighter,
//         ),
//         basicColorLightest: lerpColor(
//           basicColor.basicColorLightest,
//           other.basicColor.basicColorLightest,
//         ),
//       ),
//       successColor: SuccessColor(
//         successColorDarkest: lerpColor(
//           successColor.successColorDarkest,
//           other.successColor.successColorDarkest,
//         ),
//         successColorDark: lerpColor(
//           successColor.successColorDark,
//           other.successColor.successColorDark,
//         ),
//         successColorMedium: lerpColor(
//           successColor.successColorMedium,
//           other.successColor.successColorMedium,
//         ),
//         successColorLight: lerpColor(
//           successColor.successColorLight,
//           other.successColor.successColorLight,
//         ),
//       ),
//       alertColor: AlertColor(
//         alertColorDarkest: lerpColor(
//           alertColor.alertColorDarkest,
//           other.alertColor.alertColorDarkest,
//         ),
//         alertColorDark: lerpColor(
//           alertColor.alertColorDark,
//           other.alertColor.alertColorDark,
//         ),
//         alertColorMedium: lerpColor(
//           alertColor.alertColorMedium,
//           other.alertColor.alertColorMedium,
//         ),
//         alertColorLight: lerpColor(
//           alertColor.alertColorLight,
//           other.alertColor.alertColorLight,
//         ),
//       ),
//       errorColor: ErrorColor(
//         errorColorDarkest: lerpColor(
//           errorColor.errorColorDarkest,
//           other.errorColor.errorColorDarkest,
//         ),
//         errorColorDark: lerpColor(
//           errorColor.errorColorDark,
//           other.errorColor.errorColorDark,
//         ),
//         errorColorMedium: lerpColor(
//           errorColor.errorColorMedium,
//           other.errorColor.errorColorMedium,
//         ),
//         errorColorLight: lerpColor(
//           errorColor.errorColorLight,
//           other.errorColor.errorColorLight,
//         ),
//       ),
//       headerStyles: HeaderStyles(
//         h1: lerpTextStyle(headerStyles.h1, other.headerStyles.h1),
//         h2: lerpTextStyle(headerStyles.h2, other.headerStyles.h2),
//         h3: lerpTextStyle(headerStyles.h3, other.headerStyles.h3),
//         h4: lerpTextStyle(headerStyles.h4, other.headerStyles.h4),
//       ),
//       bodyStyles: BodyStyles(
//         b1: lerpTextStyle(bodyStyles.b1, other.bodyStyles.b1),
//         b2: lerpTextStyle(bodyStyles.b2, other.bodyStyles.b2),
//         b3: lerpTextStyle(bodyStyles.b3, other.bodyStyles.b3),
//       ),
//       spacing: Spacing(
//         xl: (spacing.xl + (other.spacing.xl - spacing.xl) * t),
//         lg: (spacing.lg + (other.spacing.lg - spacing.lg) * t),
//         md: (spacing.md + (other.spacing.md - spacing.md) * t),
//         sm: (spacing.sm + (other.spacing.sm - spacing.sm) * t),
//         xs: (spacing.xs + (other.spacing.xs - spacing.xs) * t),
//         none: (spacing.none + (other.spacing.none - spacing.none) * t),
//       ),
//     );
//   }
// }

// class PrimaryColor {
//   final Color primaryColorDarkest,
//       primaryColorDark,
//       primaryColorMedium,
//       primaryColorLight,
//       primaryColorLightest;

//   PrimaryColor({
//     required this.primaryColorDarkest,
//     required this.primaryColorDark,
//     required this.primaryColorMedium,
//     required this.primaryColorLight,
//     required this.primaryColorLightest,
//   });
// }

// class BasicColor {
//   final Color basicColorDarkest,
//       basicColorDark,
//       basicColorMedium,
//       basicColorLight,
//       basicColorLighter,
//       basicColorLightest;

//   BasicColor({
//     required this.basicColorDarkest,
//     required this.basicColorDark,
//     required this.basicColorMedium,
//     required this.basicColorLight,
//     required this.basicColorLighter,
//     required this.basicColorLightest,
//   });
// }

// class SuccessColor {
//   final Color successColorDarkest,
//       successColorDark,
//       successColorMedium,
//       successColorLight;

//   SuccessColor({
//     required this.successColorDarkest,
//     required this.successColorDark,
//     required this.successColorMedium,
//     required this.successColorLight,
//   });
// }

// class AlertColor {
//   final Color alertColorDarkest,
//       alertColorDark,
//       alertColorMedium,
//       alertColorLight;

//   AlertColor({
//     required this.alertColorDarkest,
//     required this.alertColorDark,
//     required this.alertColorMedium,
//     required this.alertColorLight,
//   });
// }

// class ErrorColor {
//   final Color errorColorDarkest,
//       errorColorDark,
//       errorColorMedium,
//       errorColorLight;

//   ErrorColor({
//     required this.errorColorDarkest,
//     required this.errorColorDark,
//     required this.errorColorMedium,
//     required this.errorColorLight,
//   });
// }

// class HeaderStyles {
//   final TextStyle h1, h2, h3, h4;

//   HeaderStyles({
//     required this.h1,
//     required this.h2,
//     required this.h3,
//     required this.h4,
//   });
// }

// class BodyStyles {
//   final TextStyle b1, b2, b3;

//   BodyStyles({required this.b1, required this.b2, required this.b3});
// }
