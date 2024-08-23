import 'package:flutter/material.dart';
import 'package:god_father/core/appThemes/app_themes.dart';

extension CustomStyles on TextTheme {
  static TextStyle get heading1 {
    return const TextStyle(
      fontSize: 20.0,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get sideMenuButtonTextStyle {
    return const TextStyle(
      fontSize: 18,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get homePageButtonTextStyle {
    return const TextStyle(
      fontSize: 15,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get homePageListTileTestStyle {
    return const TextStyle(
      fontSize: 18,
      color: Colors.yellow,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get error {
    return TextStyle(
      fontSize: 18.0,
      color: Colors.blue.shade900,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get errorDark {
    return const TextStyle(
      fontSize: 18.0,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  }
}

extension CustomColor on Color {
 static Color get homeListCardBackGroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.green : Colors.red;
  }

 static Color get yellowWhiteColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.yellow : Colors.white ;
  }

  static Color get customGreen {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.green.shade500 : Colors.green.shade700;
  }


  static Color get backGroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.grey.shade300 : Colors.red.shade900;
  }

  static Color get homePageDeleteModeBackgroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.red.shade100 : Colors.red.shade200;
  }

  static Color get appbarColor {
    return Colors.transparent.withOpacity(0.5);
  }

  static Color get customRed {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.red : Colors.red.shade700;
  }

  static Color get lightWhiteBlackColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ?  Colors.transparent.withOpacity(0.2): Colors.transparent.withOpacity(0.6);
  }

  Color get sideMenuBackGroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.white: Colors.red.shade800;
  }

  Color get textColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.grey.shade700 : Colors.white;
  }

  Color get switchActiveColor {
    return Colors.blue;
  }

  Color get switchActiveTrackColor {
    return Colors.black38;
  }

  Color get switchInactiveTrackColor {
    return Colors.transparent;
  }

  Color get trackOutlineColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.yellow : Colors.yellow.shade500;
  }

}
// extension CustomButtonStyle on ButtonStyle {
//   ButtonStyle get attendanceFooterRightButtonStyle {
//     return  ButtonStyle(
//         fixedSize: MaterialStateProperty.all(Size(
//           0,
//           SizeConfig.screenWidth > 500
//               ? SizeConfig.safeBlockHorizontal * 10
//               : SizeConfig.screenWidth > 350
//               ? SizeConfig.safeBlockHorizontal * 13
//               : SizeConfig.safeBlockHorizontal * 12,
//         )),
//         foregroundColor: MaterialStateProperty.all(Colors.white),
//         shape: MaterialStateProperty.all(
//           customShapeCornerRadiusAll(radius: 0),
//         ),
//         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//               (Set<MaterialState> states) {
//             // if (states.contains(MaterialState.selected))
//             //   return Colors.green;
//             // else
//             if (states.contains(MaterialState.disabled))
//               return Colors.grey;
//             else {
//               return Colors.green;
//             }
//             return null; // Use the component's default.
//           },
//         ),
//         elevation: MaterialStateProperty.all(0),
//         textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.5)));
//
//   }
//
//   ButtonStyle get attendanceFooterLeftButtonStyleLightTheme {
//     return ButtonStyle(
//         fixedSize: MaterialStateProperty.all(Size(
//           0,
//           SizeConfig.screenWidth > 500
//               ? SizeConfig.safeBlockHorizontal * 10
//               : SizeConfig.screenWidth > 350
//               ? SizeConfig.safeBlockHorizontal * 13
//               : SizeConfig.safeBlockHorizontal * 12,
//         )),
//         foregroundColor: MaterialStateProperty.all(Colors.white),
//         shape: MaterialStateProperty.all(
//           customShapeCornerRadiusAll(radius: 0),
//         ),
//         backgroundColor: MaterialStateProperty.resolveWith<Color>(
//               (Set<MaterialState> states) {
//             // if (states.contains(MaterialState.pressed))
//             //   return Colors.red;
//             // else if (states.contains(MaterialState.disabled)) return Colors.grey;
//             // return null; // Use the component's default.
//             if (states.contains(MaterialState.disabled))
//               return Colors.grey;
//             else {
//               return Colors.red;
//             }
//           },
//         ),
//         elevation: MaterialStateProperty.all(0),
//         textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: SizeConfig.safeBlockHorizontal * 3.5)));
//   }
// }

// ButtonStyle(
// tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// elevation: MaterialStateProperty.all(5),
// backgroundColor: MaterialStateProperty.all(Colors.red),
// shape: MaterialStateProperty.all(
// customShapeCornerRadiusAll(radius: (SizeConfig?.safeBlockHorizontal ?? 4) * 6),
// ))
