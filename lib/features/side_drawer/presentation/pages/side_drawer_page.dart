import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/enums/page_enum.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/setting_page/presentation/pages/setting_page.dart';
import 'package:god_father/features/side_drawer/presentation/bloc/side_drawer_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:god_father/features/side_drawer/presentation/pages/side_menu_background_image.dart';
import 'package:god_father/features/side_drawer/presentation/pages/side_menu_buttons_widget.dart';
import 'package:inner_drawer/inner_drawer.dart';
import '../../../../injection_container.dart';
import '../../../player_list_page/presentation/pages/player_list_page.dart';


final GlobalKey<InnerDrawerState> innerDrawerKey =
    GlobalKey<InnerDrawerState>();

class SideDrawerPage extends StatelessWidget {
  const SideDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (_) => sl<SideDrawerBloc>(),
    child: BlocBuilder<SideDrawerBloc, SideDrawerState>(
      builder: (context, state) {
        return BlocSelector<SettingsBloc, SettingState, ThemeMode?>(
          selector: (state) => state.themeMode,
          builder: (context, themeMode) {
            return InnerDrawer(
                backgroundDecoration:
                    BoxDecoration(color: CustomColor.backGroundColor),
                key: innerDrawerKey,
                onTapClose: true,
                swipe: true,
                swipeChild: true,
                proportionalChildArea: true,
                borderRadius: 20,
                leftAnimationType: InnerDrawerAnimation.linear,
                rightAnimationType: InnerDrawerAnimation.quadratic,
                onDragUpdate: (double? val, InnerDrawerDirection? direction) {
                  // return values between 1 and 0
                  debugPrint('$val');
                  // check if the swipe is to the right or to the left
                  debugPrint('${direction == InnerDrawerDirection.start}');
                },
                innerDrawerCallback: (a) => debugPrint('$a'),
                leftChild: _sideMenuBody(context),

                //  A Scaffold is generally used but you are free to use other widgets
                // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
                scaffold: Scaffold(   /// This Scaffold is to locate pages
                    backgroundColor: Colors.transparent,
                    body: BlocSelector<SideDrawerBloc, SideDrawerState,
                            PageEnum>(
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

  _sideMenuBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Stack(
        children: [
          const SideMenuBackgroundImage(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  SideMenuButton(pageEnum: PageEnum.home, title: l10n.homePage,),
                  SideMenuButton(pageEnum: PageEnum.setting, title: l10n.settings,),
                ],
              ),
            ),
          ),
        ],
    );
  }

  void _onMenuPressed() {
    innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.start);
  }
}



