import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../domain/entities/player_entity.dart';
import '../bloc/player_list_bloc.dart';

class ListToDisplay extends StatelessWidget {
  const ListToDisplay({super.key});

  // final List<Player?>? playerList;
  //
  // const ListToDisplay({super.key, required this.playerList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: BlocSelector<PlayerListBloc, PlayerListState, List<Player>>(
          selector: (state) => state.players ?? [],
          builder: (context, players) {
            return ScrollablePositionedList.builder(
              physics: const BouncingScrollPhysics(),
              itemScrollController: BlocProvider
                  .of<PlayerListBloc>(context)
                  .scrollController,
        
              itemCount: players.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 0,
                    // elevation: 0,
                    child: BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                      selector: (state) => state.isDeleteViewPressed,
                      builder: (context, isDeleteViewPressed) {
                        return ListTile(
                          onTap: () {
                            if(isDeleteViewPressed ?? false){
                              context.read<PlayerListBloc>().add(PlayerSelectedInDeleteView(players[index]));
                            }else{
                              context.read<PlayerListBloc>().add(PlayerListDeActiveSelected(players[index]));
                            }
        
                          },
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          // enabled: players[index].isActive ? true : false,
                          tileColor: players[index].isActive ? Colors.transparent.withOpacity(0.7) : Colors.transparent.withOpacity(0.3),
                          title: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Visibility(
                                  visible: isDeleteViewPressed == false ? true : false,
                                  child: Checkbox(
                                    value: players[index].isActive,
                                    onChanged: (value) {
                                      context.read<PlayerListBloc>().add(PlayerListDeActiveSelected(players[index]));
                                    },
                                  ),
                                ),
                              ),
                              Expanded(flex: 3, child: Text(players[index].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: CustomStyles.homePageListTileTestStyle)),
                              BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                                selector: (state) => state.isDeleteViewPressed,
                                builder: (context, isDeleteViewPressed) {
                                  return Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Visibility(
                                        visible: isDeleteViewPressed ?? false,
                                        child: Checkbox(
                                          value: players[index].isSelected,
                                          onChanged: (value) {
                                            context.read<PlayerListBloc>().add(PlayerSelectedInDeleteView(players[index]));
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
