import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appThemes/custom_style.dart';
import '../../../../enums/page_enum.dart';
import '../bloc/side_drawer_bloc.dart';

class SideMenuButton extends StatelessWidget {
  final String title;
  final PageEnum pageEnum;

  const SideMenuButton({super.key, required this.title, required this.pageEnum});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5))),
                onPressed: () {
                  // BPThemeNotifier.of(context,listen: false).changeThemes();
                  // context.read<SideDrawerBloc>().add(const SideMenuPagePressed(pageEnum: PageEnum.setting));
                  BlocProvider.of<SideDrawerBloc>(context).add(SideMenuPagePressed(pageEnum: pageEnum));
                  // Navigator.of(context).pop();
                  context.pop();
                },
                // child: Text(l10n.homePage, style: TextStyle(color: BPThemeNotifier.of(context).theme.colorScheme.testColor))),
                child: Text(
                  title,
                  style: CustomStyles.sideMenuButtonTextStyle,
                )),
          ),
        ),
      ],
    );
  }
}
