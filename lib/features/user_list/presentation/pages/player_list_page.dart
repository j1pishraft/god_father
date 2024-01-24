// import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/features/user_list/presentation/bloc/player_list_bloc.dart';
import 'package:god_father/features/user_list/presentation/widgets/list_display.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/player_entity.dart';
import '../widgets/add_to_list_button_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';

// @RoutePage()
class PlayerListPage extends StatelessWidget {
  const PlayerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<PlayerListBloc>();
        bloc.add(PlayerListStarted());
        return bloc;
      },
      child: GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
        child:Scaffold(
          appBar: AppBar(
            title: Stack(
              alignment: Alignment.center,
              children: [
                const Center(child: Text('Player List')),
                BlocSelector<PlayerListBloc, PlayerListState, (List<Player>?, bool?, bool?)>(
                  selector: (state) => (state.players, state.isDeleteViewPressed, state.isAllSelected),
                  builder: (context, items) {
                    final isAllSelected = items.$3;
                    final isDeletePressed = items.$2;
                    final players = items.$1;
                    return players == null || players.isEmpty
                        ? Container()
                        : isDeletePressed == true
                            ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Checkbox(
                                  value: isAllSelected ?? false,
                                  onChanged: (bool? value) {
                                    BlocProvider.of<PlayerListBloc>(context).add(PlayerListSelectAllPressed(value!));
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteViewButtonPressed());
                                    // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
                                  },
                                  icon: const Icon(Icons.cancel_outlined),
                                ),
                              ],
                            )
                            : Align(
                      alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteViewButtonPressed());
                                    // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteButtonPressed());
                                    // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                            );
                  },
                ),
              ],
            ),
          ),
          body: _buildBody(context),
        ),
      ),
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
                    :  const ListToDisplay(
                      );
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
