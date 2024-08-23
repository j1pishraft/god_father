import 'package:flutter/material.dart';
import 'package:god_father/core/appThemes/custom_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final Function? onPressed;
  final String title;
  const CustomElevatedButton({super.key, required this.backgroundColor, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // style: ElevatedButton.styleFrom(
      //
      //     backgroundColor: CustomColor.addButtonColor,
      //     fixedSize: const Size.fromHeight(60)),

      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
            const Size.fromHeight(60)),
        backgroundColor:
        WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states
                .contains(WidgetState.disabled)) {
              return Colors.transparent
                  .withOpacity(0.3);
            } else {
              return backgroundColor;
            } // Use the component's default.
          },
        ),
      ),
      onPressed: onPressed != null ? ()=> onPressed!() : null,
        // AutoRouter.of(context).push(const PlayerListRoute());

      child: Text(
        title,
        style: CustomStyles.homePageButtonTextStyle
        // style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

//
// ButtonStyle(
// fixedSize:   WidgetStateProperty.all(const Size.fromHeight(60)),
// backgroundColor:
// WidgetStateProperty.resolveWith<Color>(
// (Set<WidgetState> states) {
// if (states
//     .contains(WidgetState.disabled)) {
// return Colors.transparent.withOpacity(0.4);
// } else {
// return CustomColor.addButtonColor;
// } // Use the component's default.
// },
// ),
// ),
// onPressed: isNameDuplicated == false &&
// playerName?.isNotEmpty == true
// ? () {
// bloc.add(
// const PlayerListAddPressed());
// // AutoRouter.of(context).push(const PlayerListRoute());
// }
//     : null,
// child: Text(
// l10n.addPlayer,
// style: const TextStyle(
// color: Colors.yellow,
// ),
// // style: const TextStyle(color: Colors.white),
// ),
// ),