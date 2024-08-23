import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/widgets/custom_check_box.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_expanded_tile.dart';
import '../../domain/entities/player_entity.dart';
import '../bloc/player_list_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListToDisplay extends StatelessWidget {
  final Locale locale;
  const ListToDisplay({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    var l10n = AppLocalizations.of(context);
    return SafeArea(
      bottom: false,
      child:
          BlocSelector<PlayerListBloc, PlayerListState, Tuple5<List<Player>, List<Player>, List<Player>, bool, bool>>(
        selector: (state) => Tuple5(state.players!, state.activePlayers!, state.inactivePlayers!,
            state.isActiveListExpanded!, state.isInactiveListExpanded!),
        builder: (context, tuple) {
          // final players = tuple.value1;
          final activePlayers = tuple.value2;
          final inactivePlayers = tuple.value3;

          return ListView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: BlocProvider.of<PlayerListBloc>(context).playersListScrollController,
            children: [
              _listView(
                  context: context,
                  players: activePlayers,
                  itemScrollController: BlocProvider.of<PlayerListBloc>(context).activeListScrollController,
                  headerColor: CustomColor.customGreen,
                  title: '${l10n?.activePlayers} (${ConvertNoLocale.convertNoLocale(activePlayers.length, locale.languageCode)})',
                  isActiveTile: true),
              _listView(
                  context: context,
                  players: inactivePlayers,
                  itemScrollController: BlocProvider.of<PlayerListBloc>(context).inactiveListScrollController,
                  headerColor: CustomColor.customRed,
                  title: '${l10n?.inactivePlayers} (${ConvertNoLocale.convertNoLocale(inactivePlayers.length, locale.languageCode)})',
                  isActiveTile: false),
            ],
          );
        },
      ),
    );
  }

  Widget _listView({
    required BuildContext context,
    required List<Player> players,
    required ItemScrollController itemScrollController,
    required Color headerColor,
    required String title,
    required bool isActiveTile,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: BlocSelector<PlayerListBloc, PlayerListState, Tuple2<bool, bool>>(
              selector: (state) => Tuple2(state.isActiveListExpanded!, state.isInactiveListExpanded!),
              builder: (context, tuple) {
                final isActiveListExpanded = tuple.value1;
                final isInactiveListExpanded = tuple.value2;
                return CustomExpandedTile(
                    controller: isActiveTile
                        ? BlocProvider.of<PlayerListBloc>(context).activePlayerListController
                        : BlocProvider.of<PlayerListBloc>(context).inactivePlayerListController,
                    onTap: () {
                      if (isActiveTile) {
                        BlocProvider.of<PlayerListBloc>(context)
                            .add(ListHeaderPressed(isActiveListExpanded, isActiveTile));
                      } else {
                        BlocProvider.of<PlayerListBloc>(context)
                            .add(ListHeaderPressed(isInactiveListExpanded, isActiveTile));
                      }
                    },
                    headerColor: headerColor,
                    isExpanded: isActiveTile ? isActiveListExpanded : isInactiveListExpanded,
                    onIconPressed: () {
                      if (isActiveTile) {
                        BlocProvider.of<PlayerListBloc>(context)
                            .add(ListHeaderPressed(isActiveListExpanded, isActiveTile));
                      } else {
                        BlocProvider.of<PlayerListBloc>(context)
                            .add(ListHeaderPressed(isInactiveListExpanded, isActiveTile));
                      }
                    },
                    title: title,
                    child: ScrollablePositionedList.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemScrollController: itemScrollController,
                        itemCount: players.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Separate the players into active and inactive lists
                          bool isSelectedCheckBoxValue = players[index].isSelected;
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Material(
                              color: Colors.transparent,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                              elevation: 0,
                              child: BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                                selector: (state) => state.isDeleteViewPressed,
                                builder: (context, isDeleteViewPressed) {
                                  return ListTile(
                                    onTap: () {
                                      if (isDeleteViewPressed ?? false) {
                                        context.read<PlayerListBloc>().add(PlayerSelectedInDeleteView(
                                            players[index], isActiveTile, index, isSelectedCheckBoxValue));
                                      } else {
                                        context
                                            .read<PlayerListBloc>()
                                            .add(PlayerListIsActiveSelected(players[index], isActiveTile, index));
                                      }
                                    },
                                    shape:
                                    const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    tileColor: players[index].isActive
                                        ? Colors.transparent.withOpacity(0.9)
                                        : Colors.transparent.withOpacity(0.9),
                                    title: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Visibility(
                                            visible: isDeleteViewPressed == false ? true : false,
                                            child: CustomCheckBox(
                                              initialValue: players[index].isActive,
                                              onChanged: (value) {
                                                context
                                                    .read<PlayerListBloc>()
                                                    .add(PlayerListIsActiveSelected(players[index], isActiveTile, index));
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            players[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomStyles.homePageListTileTestStyle,
                                          ),
                                        ),
                                        BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                                          selector: (state) => state.isDeleteViewPressed,
                                          builder: (context, isDeleteViewPressed) {
                                            return Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Visibility(
                                                  visible: isDeleteViewPressed ?? false,
                                                  child: CustomCheckBox(
                                                    initialValue: players[index].isSelected,
                                                    onChanged: (value) {
                                                      context.read<PlayerListBloc>().add(PlayerSelectedInDeleteView(
                                                          players[index], isActiveTile, index, isSelectedCheckBoxValue));
                                                    },
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );}
                    ));

              }),
        ),
      ],
    );
  }
}
