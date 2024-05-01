// import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../../../../core/config_reader/config_reader.dart';
import '../../../../injection_container.dart';
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
      child: GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(FocusNode()),
        child:Scaffold(
          appBar: AppBar(
            // backgroundColor:  Color(int.parse(ConfigReader.getAppBarColor)),
            leading: IconButton(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu),
            ),
            centerTitle: true,
            actions: [
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
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteViewButtonPressed());
                          // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListDeleteButtonPressed());
                          // BlocProvider.of<PlayerListBloc>(context).add(const PlayerListClearPressed());
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ],
                  );
                },
              ),
            ],
            title: Text(AppLocalizations.of(context)!.playerList),
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
