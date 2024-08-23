import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

import '../appThemes/custom_style.dart';

class CustomExpandedTile extends StatelessWidget {
  final Widget child;
  final ExpandedTileController  controller;
  final Color headerColor;
  final Function onTap;
  final Function onIconPressed;
  final String title;
  final bool isExpanded;
  const CustomExpandedTile({super.key, required this.child, required this.controller, required this.headerColor, required this.onTap, required this.title, required this.isExpanded, required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return ExpandedTile(
      controller: controller,
      theme: ExpandedTileThemeData(
        contentSeparatorColor: Colors.transparent,
        headerColor: headerColor,
        // headerPadding: EdgeInsets.all(24.0),
        headerSplashColor: Colors.transparent,
        contentBackgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        headerPadding: const EdgeInsets.all(0),
        headerBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      trailing: const SizedBox.shrink(),
      onTap: () => onTap(),
      title: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: CustomStyles.heading1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                  onPressed: () => onIconPressed(),
                  icon: Icon(

                        isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,

                    size: 35,
                    color: Colors.yellow,
                  )),
            ],
          )
        ],
      ),
      content: child,
    );
  }
}
