import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/widgets/custom_check_box.dart';
import 'package:god_father/enums/language_enum.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
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
    var l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) {
        final bloc = sl<PlayerListBloc>();
        bloc.add(PlayerListFetched());
        return bloc;
      },
      child: BlocSelector<SettingsBloc, SettingState, (ThemeMode?, Locale? locale)>(
          selector: (state) => (state.themeMode, state.selectedLanguage?.locale),
          builder: (context, item) {
            final themeMode = item.$1;
            final locale = item.$2;
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: BlocSelector<PlayerListBloc, PlayerListState, (List<Player>?, bool?, bool?)>(
                selector: (state) => (state.players, state.isDeleteViewPressed, state.isAllSelected),
                builder: (context, items) {
                  final players = items.$1;
                  final isDeletePressed = items.$2;
                  final isAllSelected = items.$3;
                  return Scaffold(
                    extendBodyBehindAppBar: true,
                    // backgroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor:
                    isDeletePressed! ? CustomColor.homePageDeleteModeBackgroundColor : CustomColor.backGroundColor,
                    appBar: _appBar(
                        locale: locale,
                        players: players,
                        context: context,
                        isAllSelected: isAllSelected ?? false,
                        isDeletePressed: isDeletePressed),
                    body: Stack(
                      children: [
                        _backGroundImage(),
                        _buildBody(locale!, l10n),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  _backGroundImage() {
    return BlocSelector<PlayerListBloc, PlayerListState, bool?>(
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
                      ImageAssetPaths.homePageBackgroundImageEnLocale,
                    ),
                  ),
                )
                    : Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Center(
                    child: Image.asset(
                      ImageAssetPaths.homePageBackgroundImageFaLocale,
                    ),
                  ),
                );
              });
        });
  }

  _appBar({required bool isAllSelected,
    required bool isDeletePressed,
    List<Player>? players,
    required BuildContext context,
    Locale? locale}) {
    return AppBar(
      backgroundColor: isDeletePressed ? CustomColor.customRed : CustomColor.appbarColor,
      centerTitle: true,
      leading: IconButton(
        color: Colors.yellow,
        onPressed: onMenuPressed,
        icon: const Icon(Icons.menu),
      ),
      title:  Text(
          isDeletePressed
              ? AppLocalizations.of(context)!.removePlayer
              : AppLocalizations.of(context)!.playerList,
          style: CustomStyles.heading1),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Wrap(
      //       crossAxisAlignment: WrapCrossAlignment.center,
      //       direction: Axis.vertical,
      //       // spacing: 10.0, // Space between elements vertically
      //       // runSpacing: 10.0, // Space between rows horizontally
      //       children: [
      //         Text(
      //             isDeletePressed
      //                 ? AppLocalizations.of(context)!.removePlayer
      //                 : AppLocalizations.of(context)!.playerList,
      //             style: CustomStyles.heading1),
      //         players != null && players.isNotEmpty
      //             ? Text(
      //             _getTotalPlayersCount(players.length, locale.toString()),
      //             style: CustomStyles.heading1)
      //             : Container(),
      //       ],
      //     ),
      //   ],
      // ),
      actions: [
        players == null || players.isEmpty
            ? Container()
            : isDeletePressed == true
            ? Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomCheckBox(
              initialValue: isAllSelected,
              onChanged: (value) {
                BlocProvider.of<PlayerListBloc>(context).add(PlayerListSelectAllPressed(value!));
              },
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteViewButtonPressed());
                // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.yellow),
            ),
          ],
        )
            : IconButton(
          onPressed: () {
            BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteViewButtonPressed());
            // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteButtonPressed());
            // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
          },
          icon: const Icon(Icons.delete_forever, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildBody(Locale locale, var l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // const SizedBox(height: 10),
            BlocBuilder<PlayerListBloc, PlayerListState>(builder: (context, state) {
              final bloc = BlocProvider.of<PlayerListBloc>(context);
              if (state.status == PlayerListStatus.loading) {
                return const LoadingWidget();
              } else if (state.status == PlayerListStatus.loaded) {
                return bloc.state.players?.isEmpty == true
                    ? MessageDisplay(
                  defaultMessage: l10n.somethingWentWrong,
                  message: l10n.pleaseAddPlayers,
                )
                    : Expanded(child: ListToDisplay(locale: locale,));
              } else if (state.status == PlayerListStatus.error) {
                //TODO: Think of a proper way to send the message here. what if we need to localize stuff????
                return MessageDisplay(
                  defaultMessage: l10n.somethingWentWrong,
                  message: state.errorMessage,
                );
              } else {
                return Container();
              }
            }),
            const SizedBox(height: 10),
            AddToListButton(locale: locale,),
          ],
        ),
      ),
    );
  }

  String _getActivePlayersCount(List<Player> players, String locale) {
    return ConvertNoLocale.convertNoLocale(players
        .where((player) => player.isActive)
        .length, locale);
  }

  String _getTotalPlayersCount(int playersLength, String locale) {
    return ConvertNoLocale.convertNoLocale(playersLength, locale);
  }

}
