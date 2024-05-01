import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/enums/page_enum.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/setting_page/presentation/pages/setting_page.dart';
import 'package:god_father/features/side_drawer/presentation/bloc/side_drawer_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inner_drawer/inner_drawer.dart';
import '../../../../core/appThemes/app_themes.dart';
import '../../../../core/constants/color_const.dart';
import '../../../../injection_container.dart';
import '../../../player_list_page/presentation/pages/player_list_page.dart';

final GlobalKey<InnerDrawerState> innerDrawerKey = GlobalKey<InnerDrawerState>();

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SideDrawerBloc>(),
      child: BlocBuilder<SideDrawerBloc, SideDrawerState>(
        builder: (context, state) {
          return
            BlocSelector<SettingsBloc, SettingState, ThemeMode?>(
            selector: (state) => state.themeMode,
            builder: (context, themeMode) {
              return
                InnerDrawer(
                  backgroundDecoration: BoxDecoration(color: customColor.sideMenuBackGroundColor),
                  key: innerDrawerKey,
                  onTapClose: true,
                  swipe: true,
                  swipeChild: true,
                  proportionalChildArea: true,
                  borderRadius: 20,
                  leftAnimationType: InnerDrawerAnimation.quadratic,
                  rightAnimationType: InnerDrawerAnimation.quadratic,
                  onDragUpdate: (double? val, InnerDrawerDirection? direction) {
                    // return values between 1 and 0
                    debugPrint('$val');
                    // check if the swipe is to the right or to the left
                    debugPrint('${direction == InnerDrawerDirection.start}');
                  },
                  innerDrawerCallback: (a) => debugPrint('$a'),
                  leftChild: _buildBody(context),

                  //  A Scaffold is generally used but you are free to use other widgets
                  // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
                  scaffold: Scaffold(
                      backgroundColor: ThemeManager.currentThemeMode == ThemeMode.light ? Colors.white : Colors.grey,
                      body: BlocSelector<SideDrawerBloc, SideDrawerState, PageEnum>(
                          selector: (state) => state.sideSelectedPageEnum,
                          builder: (context, sideSelectedPageEnum) {
                            switch (sideSelectedPageEnum) {
                              case PageEnum.home:
                                return PlayerListPage(
                                  onMenuPressed: _onMenuPressed,
                                );
                              case PageEnum.setting:
                                return const SettingsPage();
                              default:
                                return PlayerListPage(
                                  onMenuPressed: _onMenuPressed,
                                );
                            }
                          })));
            },
          );
        },
      ),
    );
  }

  _buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            TextButton(
                onPressed: () {
                  // BPThemeNotifier.of(context,listen: false).changeThemes();
                  // context.read<SideDrawerBloc>().add(const SideMenuPagePressed(pageEnum: PageEnum.setting));
                  BlocProvider.of<SideDrawerBloc>(context).add(const SideMenuPagePressed(pageEnum: PageEnum.home));
                  Navigator.of(context).pop();
                },
                // child: Text(l10n.homePage, style: TextStyle(color: BPThemeNotifier.of(context).theme.colorScheme.testColor))),
                child: Text(l10n.homePage,
                    style: TextStyle(
                      color: context.read<SettingsBloc>().state.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
                    ))),
            TextButton(
                onPressed: () {
                  context.read<SideDrawerBloc>().add(const SideMenuPagePressed(pageEnum: PageEnum.setting));
                  Navigator.of(context).pop();
                },
                // child: Text(l10n.settings, style: TextStyle(color: BPThemeNotifier.of(context).theme.colorScheme.testColor,)))
                child: Row(
                  children: [
                    Text(l10n.settings,
                        style: TextStyle(
                          // color: context.read<SettingsBloc>().state.appTheme == AppTheme.darkTheme ? Colors.red : Colors.green,
                          color: customColor.textColor,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _onMenuPressed() {
    innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.start);
  }
}

