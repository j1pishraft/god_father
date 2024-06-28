// import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/enums/language_enum.dart';

import '../../../../core/appThemes/app_themes.dart';
import '../../../../injection_container.dart';
import '../../../setting_page/presentation/bloc/setting_bloc.dart';
import '../../domain/entities/player_entity.dart';
import '../bloc/player_list_bloc.dart';
import '../widgets/add_to_list_button_widget.dart';
import '../widgets/list_display.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// @RoutePage()
class PlayerListPage extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const PlayerListPage({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<PlayerListBloc>();
        bloc.add(PlayerListStarted());
        return bloc;
      },
      child: BlocSelector<SettingsBloc, SettingState, ThemeMode?>(
          selector: (state) => state.themeMode,
          builder: (context, themeMode) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: BlocSelector<PlayerListBloc, PlayerListState, (List<Player>?, bool?, bool?)>(
                selector: (state) => (state.players, state.isDeleteViewPressed, state.isAllSelected),
                builder: (context, items) {
                  final isAllSelected = items.$3;
                  final isDeletePressed = items.$2;
                  final players = items.$1;
                  return Scaffold(
                    extendBodyBehindAppBar: true,
                    // backgroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: isDeletePressed! ? CustomColor.homePageDeleteModeBackgroundColor : CustomColor.backGroundColor,
                    appBar: AppBar(
                      backgroundColor: isDeletePressed ? CustomColor.customRed : CustomColor.appbarColor,
                      leading: IconButton(
                        color: Colors.yellow,
                        onPressed: onMenuPressed,
                        icon: const Icon(Icons.menu),
                      ),
                      centerTitle: true,
                      actions: [
                        players == null || players.isEmpty
                            ? Container()
                            : isDeletePressed == true
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Checkbox(
                                        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                          if (states.contains(WidgetState.selected)) {
                                            return Colors.green; // Color when the checkbox is selected
                                          }
                                          return Colors.white; // Color when the checkbox is unselected
                                        }),
                                        side: WidgetStateBorderSide.resolveWith(
                                          (Set<WidgetState> states) {
                                            if (states.contains(WidgetState.selected)) {
                                              return const BorderSide(
                                                  color: Colors.red, width: 1); // Border color when selected
                                            }
                                            return const BorderSide(
                                                color: Colors.red, width: 1); // Border color when unselected
                                          },
                                        ),
                                        checkColor: ThemeManager.currentThemeMode == ThemeMode.light
                                            ? Colors.green
                                            : Colors.white,
                                        activeColor: ThemeManager.currentThemeMode == ThemeMode.light
                                            ? Colors.green
                                            : Colors.green,
                                        overlayColor: ThemeManager.currentThemeMode == ThemeMode.light
                                            ? WidgetStateProperty.all(Colors.black)
                                            : WidgetStateProperty.all(Colors.white),
                                        value: isAllSelected ?? false,
                                        onChanged: (bool? value) {
                                          BlocProvider.of<PlayerListBloc>(context)
                                              .add(PlayerListSelectAllPressed(value!));
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          BlocProvider.of<PlayerListBloc>(context)
                                              .add(const PlayerListDeleteViewButtonPressed());
                                          // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
                                        },
                                        icon: const Icon(Icons.cancel_outlined, color: Colors.yellow),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          BlocProvider.of<PlayerListBloc>(context)
                                              .add(const PlayerListDeleteViewButtonPressed());
                                          // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteButtonPressed());
                                          // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
                                        },
                                        icon: const Icon(Icons.delete_forever, color: Colors.red),
                                      ),
                                    ],
                                  ),
                      ],
                      title: Text(
                          isDeletePressed
                              ? AppLocalizations.of(context)!.removePlayer
                              : AppLocalizations.of(context)!.playerList,
                          style: CustomStyles.heading1),
                    ),
                    body: Stack(
                      children: [
                        BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                            selector: (state) => state.isDeleteViewPressed,
                            builder: (context, isDeleteViewPressed) {
                              return isDeleteViewPressed!
                                  ? Container()
                                  : BlocSelector<SettingsBloc, SettingState, Locale?>(
                                      selector: (state) => state.selectedLanguage?.locale,
                                      builder: (context, cLocale) {
                                        final locale = cLocale;
                                        return locale?.languageCode == 'en'
                                            ? Positioned(
                                                left: 0,
                                                bottom: 0,
                                                top: 0,
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/r_godfather.png",
                                                  ),
                                                ),
                                              )
                                            : Positioned(
                                                right: 0,
                                                bottom: 0,
                                                top: 0,
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/flip_l_godfather.png",
                                                  ),
                                                ),
                                              );
                                      });
                            }),
                        _buildBody(context),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            BlocBuilder<PlayerListBloc, PlayerListState>(builder: (context, state) {
              final bloc = BlocProvider.of<PlayerListBloc>(context);
              if (state.status == PlayerListStatus.loading) {
                return const LoadingWidget();
              } else if (state.status == PlayerListStatus.loaded) {
                return bloc.state.players?.isEmpty == true
                    ? const MessageDisplay(
                        message: 'Please add player!',
                      )
                    : const ListToDisplay();
              } else if (state.status == PlayerListStatus.error) {
                //TODO: Think of a proper way to send the message here. what if we need to localize stuff????
                return MessageDisplay(
                  message: state.errorMessage,
                );
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 20),
            const AddToListButton(),
          ],
        ),
      ),
    );
  }
}
