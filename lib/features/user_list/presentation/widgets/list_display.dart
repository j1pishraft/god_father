import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/features/user_list/presentation/bloc/player_list_bloc.dart';
import '../../domain/entities/player_entity.dart';

class ListToDisplay extends StatelessWidget {
  const ListToDisplay({super.key});

  // final List<Player?>? playerList;
  //
  // const ListToDisplay({super.key, required this.playerList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<PlayerListBloc, PlayerListState, List<Player>>(
        selector: (state) => state.players ?? [],
        builder: (context, players) {
          return ListView.builder(
            controller: BlocProvider
                .of<PlayerListBloc>(context)
                .scrollController,

            itemCount: players.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: players[index].isActive ? 3 : 0,
                  child: BlocSelector<PlayerListBloc, PlayerListState, bool?>(
                    selector: (state) => state.isDeleteViewPressed,
                    builder: (context, isDeleteViewPressed) {
                      return ListTile(
                        onTap: () {
                          if(isDeleteViewPressed ?? false){
                            context.read<PlayerListBloc>().add(PlayerSelected(players[index]));
                          }else{
                            context.read<PlayerListBloc>().add(PlayerListDeActiveSelected(players[index]));
                          }

                        },
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        // enabled: players[index].isActive ? true : false,
                        tileColor: players[index].isActive ? Colors.white : Colors.grey.shade300,
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
                            Expanded(flex: 4, child: Text(players[index].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: players[index].isActive ? Colors.black : Colors.grey,),)),
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
                                          context.read<PlayerListBloc>().add(PlayerSelected(players[index]));
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
    );
  }
}
