import 'package:flutter/material.dart';

import '../appThemes/app_themes.dart';

class CustomCheckBox extends StatelessWidget {
  final bool initialValue;
  final Function(bool?) onChanged;
  const CustomCheckBox({super.key, required this.initialValue, required this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Checkbox(
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.yellow; // Color when the checkbox is selected
        }
        return Colors.black12; // Color when the checkbox is unselected
      }),
      side: WidgetStateBorderSide.resolveWith(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(
                color: Colors.yellow, width: 1); // Border color when selected
          }
          return const BorderSide(
              color: Colors.yellow, width: 2); // Border color when unselected
        },
      ),
      checkColor: Colors.red.shade900,
      activeColor: ThemeManager.currentThemeMode == ThemeMode.light
          ? Colors.green
          : Colors.green,
      overlayColor: ThemeManager.currentThemeMode == ThemeMode.light
          ? WidgetStateProperty.all(Colors.black)
          : WidgetStateProperty.all(Colors.white),
      value: initialValue,
      onChanged: onChanged,

    );
  }
}
// abstract class CustomCheckBox extends StatelessWidget {
//   final bool isSelected;
//   Function onPressed();
//   const CustomCheckBox({super.key, required this.isSelected,});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
//         if (states.contains(WidgetState.selected)) {
//           return Colors.green; // Color when the checkbox is selected
//         }
//         return Colors.white; // Color when the checkbox is unselected
//       }),
//       side: WidgetStateBorderSide.resolveWith(
//             (Set<WidgetState> states) {
//           if (states.contains(WidgetState.selected)) {
//             return const BorderSide(
//                 color: Colors.red, width: 1); // Border color when selected
//           }
//           return const BorderSide(
//               color: Colors.red, width: 1); // Border color when unselected
//         },
//       ),
//       checkColor: ThemeManager.currentThemeMode == ThemeMode.light
//           ? Colors.green
//           : Colors.white,
//       activeColor: ThemeManager.currentThemeMode == ThemeMode.light
//           ? Colors.green
//           : Colors.green,
//       overlayColor: ThemeManager.currentThemeMode == ThemeMode.light
//           ? WidgetStateProperty.all(Colors.black)
//           : WidgetStateProperty.all(Colors.white),
//       value: isSelected,
//       onChanged: (bool? value) {
//         BlocProvider.of<PlayerListBloc>(context)
//             .add(PlayerListSelectAllPressed(value!));
//       },
//     );
//   }
// }
