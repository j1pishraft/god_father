import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/widgets/custom_elevated_button.dart';
import '../../../../app/routes/app_router.dart';
import '../../../../app/routes/route_utils.dart';
import '../../domain/entities/player_entity.dart';
import '../bloc/player_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddToListButton extends StatelessWidget {
  final String? errorMessage;

  const AddToListButton({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var bloc = context.read<PlayerListBloc>();
    return Column(
      children: [
        BlocSelector<PlayerListBloc, PlayerListState, (bool?, bool?)>(
          selector: (state) => (state.isNameDuplicated, state.isDeleteViewPressed),
          builder: (context, item) {
            final isNameDuplicated = item.$1;
            final isDeleteViewPressed = item.$2;
            return isDeleteViewPressed == false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.yellow),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (isNameDuplicated == true) {
                          return l10n.playerNameAlreadyExisted;
                        } else {
                          return null;
                        }
                      },

                      controller: bloc.textEditingController,
                      // to trigger disabledBorder
                      decoration: InputDecoration(
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
                        bloc.add(PlayerListNameChanged(value.trimLeft()));
                      },
                      focusNode: bloc.focusNode,
                    ),
                  )
                : Container();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BlocSelector<PlayerListBloc, PlayerListState, (String?, bool?, bool?, List<Player>?)>(
                selector: (state) =>
                    (state.playerName, state.isNameDuplicated, state.isDeleteViewPressed, state.players),
                builder: (context, items) {
                  final playerName = items.$1;
                  final isNameDuplicated = items.$2;
                  final isDeleteViewPressed = items.$3;
                  final players = items.$4;
                  return isDeleteViewPressed ?? false
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomElevatedButton(
                            title: 'Delete selected player(s)',
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
                                  backgroundColor: CustomColor.addButtonColor,
                                  onPressed: isNameDuplicated == false && playerName?.isNotEmpty == true
                                      ? () {
                                          bloc.add(const PlayerListAddPressed());
                                        }
                                      : null,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomElevatedButton(
                                  title: 'Select role',
                                  backgroundColor: CustomColor.addButtonColor,
                                  onPressed: ()=> AppRouter.router.push(PAGES.selectRoles.screenPath),
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
