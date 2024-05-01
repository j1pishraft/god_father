import 'package:flutter/material.dart';
import 'package:god_father/core/appThemes/app_themes.dart';

extension CustomStyles on TextTheme {
  TextStyle get error {
    return TextStyle(
      fontSize: 18.0,
      color: Colors.blue.shade900,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get errorDark {
    return const TextStyle(
      fontSize: 18.0,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  }
}

extension CustomColor on Color {
  Color get homeListCardBackGroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.green : Colors.red;
  }

  Color get sideMenuBackGroundColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.white : Colors.grey.shade800;
  }

  Color get textColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.grey.shade700 : Colors.white;
  }

  Color get switchActiveColor {
    return Colors.blue;
  }

  Color get switchActiveTrackColor {
    return Colors.grey;
  }

  Color get switchInactiveTrackColor {
    return Colors.blue;
  }

  Color get trackOutlineColor {
    return ThemeManager.currentThemeMode == ThemeMode.light ? Colors.grey.shade700 : Colors.blue;
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
