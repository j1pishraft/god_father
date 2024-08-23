import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:god_father/features/role_list_page/presentation/pages/show_player_roles.dart';

import '../../../../injection_container.dart';
import '../../../player_list_page/domain/entities/player_entity.dart';
import '../../domain/entities/player_role_entity.dart';
import '../bloc/role_list_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

class AssignRolesPage extends StatefulWidget {
  final RoleListBloc roleListBloc;

  const AssignRolesPage({super.key, required this.roleListBloc});

  @override
  State<AssignRolesPage> createState() => _AssignRolesPageState();
}

class _AssignRolesPageState extends State<AssignRolesPage> {
  late AudioPlayer audioPlayer; // Declare AudioPlayer instance
  @override
  void initState() {
    super.initState();

    // Add the event when the widget is first created
    audioPlayer = AudioPlayer(); // Initialize AudioPlayer in initState
    widget.roleListBloc.add(const PlayerRoleAssigned());
  }

  Future<void> playBeep() async {
    // await audioPlayer.setSource(AssetSource('sounds/beep.mp3'));
    await audioPlayer.play(AssetSource('sounds/beep.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: widget.roleListBloc,
        child: BlocSelector<RoleListBloc, RoleListState, List<Player>?>(
            selector: (state) => state.playersWithRole,
            builder: (context, playersWithRole) {
              return Scaffold(
                  appBar: AppBar(),
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Expanded(
                        child: SafeArea(
                          bottom: false,
                          child: Material(
                            color: Colors.white,
                            child: _rolesList(context, playersWithRole ?? [], Colors.red),
                            // child: ListView.builder(
                            //     physics: AlwaysScrollableScrollPhysics(),
                            //     itemCount: playersWithRole?.length ?? 0,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       // if (!playersWithRole![index].isVisible) {
                            //       //   return Container(height: 50,); // Return an empty widget for invisible items
                            //       // }
                            //
                            //       return Visibility(
                            //         maintainAnimation: true,
                            //         maintainState: true,
                            //         maintainSize: true,
                            //         visible: playersWithRole![index].isVisible,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: ListTile(
                            //             tileColor: Colors.green,
                            //             onLongPress: () {
                            //               widget.roleListBloc.add(ToggleVisibilityPressed(index));
                            //               showDialog(
                            //                   context: context,
                            //                   builder: (BuildContext dialogContext) {
                            //                     return Dialog(
                            //                       child: Wrap(
                            //                         children: [
                            //                           Center(
                            //                               child: Text(
                            //                             playersWithRole[index].playerRole!.roleName!,
                            //                             style: TextStyle(fontSize: 30),
                            //                           )),
                            //                         ],
                            //                       ),
                            //                     );
                            //                   });
                            //             },
                            //             title: Text(playersWithRole![index].name),
                            //           ),
                            //         ),
                            //       );
                            //     }),
                          ),
                        ),
                      ),
                      SafeArea(
                        top: false,
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () async {
                                        await playBeep();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context1) => ShowPlayerRoles(
                                              players: playersWithRole!,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.orange)),
                                      child: const Text(
                                        'Show Roles',
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            }));
  }

  _rolesList(BuildContext context, List<Player> playersWithRole, Color listBgndColor) {
    return Wrap(
      // spacing: 3.0, // Horizontal spacing between items
      // runSpacing: 1.0, // Vertical spacing between rows
      children: List.generate(
        playersWithRole.length, // Replace with your actual itemCount
        (index) => Container(
          width: MediaQuery.of(context).size.width / 2, // Width of each item
          // Height of each item

          child: Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: playersWithRole[index].isVisible,
            child: Card(
              color: Colors.black.withOpacity(0.5),
              child: InkWell(
                onLongPress: () {
                  widget.roleListBloc.add(ToggleVisibilityPressed(index));
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return Dialog(
                          child: Wrap(
                            children: [
                              Center(
                                  child: Text(
                                playersWithRole[index].playerRole!.roleName!,
                                style: TextStyle(fontSize: 30),
                              )),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          playersWithRole[index].name ?? '',
                          style: TextStyle(fontSize: 25, color: Colors.yellow),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
