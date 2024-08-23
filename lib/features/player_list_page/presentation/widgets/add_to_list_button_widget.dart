import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/widgets/custom_elevated_button.dart';
import 'package:god_father/core/widgets/custom_toast.dart';
import 'package:intl/intl.dart';
import '../../../../app/routes/app_router.dart';
import '../../../../app/routes/route_utils.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/player_entity.dart';
import '../bloc/player_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddToListButton extends StatelessWidget {
  final String? errorMessage;
  final Locale? locale;

  const AddToListButton({super.key, this.errorMessage, this.locale});

  @override
  Widget build(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);
    final l10n = AppLocalizations.of(context)!;
    var bloc = context.read<PlayerListBloc>();
    return Column(
      children: [
        _textField(l10n, bloc),
        const SizedBox(height: 10),
        _bottomButtons(l10n, bloc, fToast),
      ],
    );
  }

  _textField(var l10n, var bloc) {
    return BlocSelector<PlayerListBloc, PlayerListState, (bool?, bool?, bool?, bool?)>(
      selector: (state) =>
          (state.isNameDuplicated, state.isDeleteViewPressed, state.isInputIsDiffLang, state.isInputContainSpecialChar),
      builder: (context, item) {
        final isNameDuplicated = item.$1;
        final isDeleteViewPressed = item.$2;
        final isInputIsDiffLang = item.$3;
        final isInputContainSpecialChar = item.$4;
        return isDeleteViewPressed == false
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))],
                  style: const TextStyle(color: Colors.yellow),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (isNameDuplicated == true) {
                      return l10n.playerNameAlreadyExistedError;
                    }
                    // if (isInputIsDiffLang!) {
                    //   return l10n.textFieldInputLocaleError;
                    // }
                    if (isInputContainSpecialChar!) {
                      return l10n.textFieldAllowedInputError;
                    }
                    return null;
                  },
                  buildCounter: (
                    BuildContext context, {
                    required int currentLength,
                    required int? maxLength,
                    required bool isFocused,
                  }) {
                    if (isNameDuplicated! || isInputContainSpecialChar!) {
                      return Row(
                        children: [
                          Flexible(
                            child: Card(
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  isNameDuplicated
                                      ? l10n.playerNameAlreadyExistedError
                                      : l10n.textFieldAllowedInputError,
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return null;
                  },
                  controller: bloc.textEditingController,
                  // to trigger disabledBorder
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                      filled: true,
                      fillColor: Colors.transparent.withOpacity(0.5),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.yellow)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1.5, color: Colors.yellow)),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      labelText: l10n.enterPlayerName,
                      labelStyle: const TextStyle(fontSize: 16, color: Colors.yellow),
                      errorMaxLines: 1),
                  onChanged: (value) {
                    // context.read<PlayerListBloc>().add(PlayerListNameChanged(value));
                    // context.read<PlayerListBloc>().scrollController.jumpTo(context.read<PlayerListBloc>().scrollController.position.maxScrollExtent);
                    bloc.add(
                      PlayerNameChanged(value.trimLeft()),
                    );
                  },
                  focusNode: bloc.focusNode,
                ),
              )
            : Container();
      },
    );
  }

  _bottomButtons(var l10n, var bloc, var fToast) {
    return Row(
      children: [
        Expanded(
          child: BlocSelector<PlayerListBloc, PlayerListState,
              (String?, bool?, bool?, List<Player>?, bool?, bool?, List<Player>?)>(
            selector: (state) => (
              state.playerName,
              state.isNameDuplicated,
              state.isDeleteViewPressed,
              state.players,
              state.isInputIsDiffLang,
              state.isInputContainSpecialChar,
              state.activePlayers
            ),
            builder: (context, items) {
              final playerName = items.$1;
              final isNameDuplicated = items.$2;
              final isDeleteViewPressed = items.$3;
              final players = items.$4;
              final isInputIsDiffLang = items.$5;
              final isInputContainSpecialChar = items.$6;
              final activePlayer = items.$7;
              return isDeleteViewPressed ?? false
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        title: l10n.deleteSelectedPlayers,
                        backgroundColor: CustomColor.customRed,
                        onPressed: players?.any((player) => player.isSelected) ?? false
                            ? () {
                                bloc.add(const PlayerListDeleteSelectedPlayersPressed());

                                // AutoRouter.of(context).push(const PlayerListRoute());
                              }
                            : null,
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                              title: l10n.addPlayer,
                              backgroundColor: CustomColor.customGreen,
                              onPressed: isNameDuplicated == false &&
                                      isInputContainSpecialChar == false &&
                                      playerName?.isNotEmpty == true
                                  ? () {
                                      bloc.add(const PlayerListAddButtonPressed());
                                    }
                                  : null,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                                title:
                                    '${l10n.selectRoles} (${_getActivePlayersCount(activePlayer ?? [], locale.toString())})',
                                backgroundColor: CustomColor.customGreen,
                                onPressed: () {
                                  final activePlayers = players!.where((player) => player.isActive).toList();
                                  if (activePlayers.length < 4) {
                                    showCustomToast(context, l10n.atLeastSelect4Players);
                                  } else {
                                    AppRouter.router.push(PAGES.selectRoles.screenPath, extra: activePlayers);
                                  }
                                }),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ],
    );
  }

  String _getActivePlayersCount(List<Player> players, String locale) {
    return ConvertNoLocale.convertNoLocale(players.where((player) => player.isActive).length, locale);
  }
}
