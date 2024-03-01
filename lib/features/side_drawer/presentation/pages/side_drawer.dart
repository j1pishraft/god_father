import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/enums/page_enum.dart';
import 'package:god_father/features/setting_page/domain/entities/app_language_entity.dart';
import 'package:god_father/features/setting_page/presentation/bloc/setting_bloc.dart';
import 'package:god_father/features/setting_page/presentation/pages/setting_page.dart';
import 'package:god_father/features/side_drawer/presentation/bloc/side_drawer_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inner_drawer/inner_drawer.dart';
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
          return InnerDrawer(

              key: innerDrawerKey,
              onTapClose: true,
              // default false
              swipe: true,
              swipeChild: true,
              // default true
//        colorTransitionChild: Color.red, // default Color.black54
//        colorTransitionScaffold: Color.black54, // default Color.black54

              //When setting the vertical offset, be sure to use only top or bottom
              // offset: const IDOffset.only(bottom: 0.0, right: 0.0, left: 0.6),

//        scale: IDOffset.horizontal( 0.8 ), // set the offset in both directions

              proportionalChildArea: true,
              // default true
              borderRadius: 20,
              // default 0
              leftAnimationType: InnerDrawerAnimation.quadratic,
              // default static
              rightAnimationType: InnerDrawerAnimation.quadratic,
              // colorTransitionChild: Colors.blue,

              backgroundDecoration: const BoxDecoration(color: Colors.white),

              // backgroundDecoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         colors: currentTheme.currentTheme == ThemeMode.light ? [Colors.blue, Colors.white] : [Colors.black, Colors.black],
              //         begin: AlignmentDirectional.topCenter,
              //         end: AlignmentDirectional.bottomCenter)),
              // default  Theme.of(context).backgroundColor

              //when a pointer that is in contact with the screen and moves to the right or left
              onDragUpdate: (double? val, InnerDrawerDirection? direction) {
                // return values between 1 and 0
                print(val);
                // check if the swipe is to the right or to the left
                print(direction == InnerDrawerDirection.start);
              },
              innerDrawerCallback: (a) => print(a),


              leftChild: _buildBody(context),


              //  A Scaffold is generally used but you are free to use other widgets
              // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
              scaffold: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: BlocSelector<SideDrawerBloc, SideDrawerState, PageEnum>(
                      selector: (state) => state.sideSelectedPageEnum,
                      builder: (context, sideSelectedPageEnum) {
                        switch (sideSelectedPageEnum){
                          case PageEnum.home:
                            return PlayerListPage(onMenuPressed: _onMenuPressed,);
                          case PageEnum.setting:
                            return const SettingsPage();
                          default:
                            return PlayerListPage(onMenuPressed: _onMenuPressed,);
                        }

                      })));
        },
      ),
    );
  }

  _buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child:
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                TextButton(
                    onPressed: () {
                      // context.read<SideDrawerBloc>().add(const SideMenuPagePressed(pageEnum: PageEnum.setting));
                      BlocProvider.of<SideDrawerBloc>(context).add(const SideMenuPagePressed(pageEnum: PageEnum.home));
                      Navigator.of(context).pop();
                    },
                    child: Text(l10n.homePage)),
                TextButton(
                    onPressed: () {
                      context.read<SideDrawerBloc>().add(const SideMenuPagePressed(pageEnum: PageEnum.setting));
                      Navigator.of(context).pop();
                    },
                    child: Text(l10n.settings))
              ],

                   ),
           ),
    );
  }

  void _onMenuPressed() {
    innerDrawerKey.currentState?.toggle(direction: InnerDrawerDirection.start);
  }
}
// import 'package:flutter/material.dart';
// import 'package:god_father/features/setting_page/presentation/pages/setting_page.dart';
// import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../player_list_page/presentation/pages/player_list_page.dart';
//
// class HiddenDrawer extends StatelessWidget {
//   const HiddenDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return HiddenDrawerMenu(
//       verticalScalePercent: 100,
//       initPositionSelected: 0,
//       disableAppBarDefault: true,
//       backgroundColorMenu: Colors.transparent,
//       screens: [
//         ScreenHiddenDrawer(
//           ItemHiddenMenu(
//               name: 'test',
//               baseStyle: const TextStyle(
//                 color: Colors.blue,
//               ),
//               selectedStyle: const TextStyle(
//                 color: Colors.blue,
//               )),
//           const PlayerListPage(),
//         ),
//         ScreenHiddenDrawer(
//           ItemHiddenMenu(
//               name: AppLocalizations.of(context)!.settings,
//               baseStyle: const TextStyle(
//                 color: Colors.blue,
//               ),
//               selectedStyle: const TextStyle(
//                 color: Colors.blue,
//               )),
//           const Settings(),
//         )
//       ],
//     );
//   }
// }
