import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:god_father/core/appThemes/custom_style.dart';
import 'package:god_father/core/widgets/custom_check_box.dart';
import 'package:god_father/core/widgets/custom_elevated_button.dart';
import 'package:god_father/core/widgets/custom_expanded_tile.dart';
import 'package:god_father/features/role_list_page/domain/entities/player_role_entity.dart';
import 'package:god_father/features/role_list_page/presentation/pages/assign_role_page.dart';

import '../../../../app/routes/app_router.dart';
import '../../../../app/routes/route_utils.dart';
import '../../../../injection_container.dart';
import '../../../player_list_page/domain/entities/player_entity.dart';
import '../bloc/role_list_bloc.dart';

class RoleListPage extends StatelessWidget {
  final List<Player> players;

  const RoleListPage({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        // debugPrint('$players');
        final bloc = sl<RoleListBloc>();
        bloc.add(PlayerAddedToState(players));
        bloc.add(RoleListFetched(players: players));
        return bloc;
      },
      child: BlocListener<RoleListBloc, RoleListState>(
          listener: (context, state) {
            if (state.status == RoleListStatus.error) {
              Fluttertoast.showToast(
                msg: "An error occurred",
                // Your error message here
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0,
              );
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Dialog(child: Text('No of selected roles Cant be more than players'));
              //   },
              // );
              // Show toast message on error state
              // Fluttertoast.showToast(
              //     msg: "An error occurred",  // Your error message here
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.BOTTOM,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.black,
              //     fontSize: 16.0,);
            }
          },
          child: Builder(
            builder: (context) => _buildBody(context),
          ) // Your actual page content widget
          ),
    );
  }

  _buildBody(BuildContext context) {
    var bloc = BlocProvider.of<RoleListBloc>(context);
    return Scaffold(
        backgroundColor: CustomColor.backGroundColor,
        appBar: _appbar(),
        body: BlocSelector<RoleListBloc, RoleListState, bool?>(
            selector: (state) => state.isSelectionError,
            builder: (context, isSelectionError) {
              // Show toast message on error state
              if (isSelectionError ?? false) {
                Fluttertoast.showToast(
                  msg: "An error occurred",
                  // Your error message here
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.black,
                  fontSize: 16.0,
                );
              }
              return BlocSelector<
                      RoleListBloc,
                      RoleListState,
                      (
                        List<PlayerRole>,
                        List<PlayerRole>,
                        List<PlayerRole>,
                        List<PlayerRole>,
                        bool?,
                        bool?,
                        bool?,
                        bool?,
                      )>(
                  selector: (state) => (
                        state.roles ?? [],
                        state.citizenRoles ?? [],
                        state.mafiaRoles ?? [],
                        state.freeRoles ?? [],
                        state.isRoleSelected,
                        state.isCitizenListExpanded,
                        state.isMafiaListExpanded,
                        state.isFreeListExpanded
                      ),
                  builder: (context, item) {
                    final roles = item.$1;
                    final citizenRoles = item.$2;
                    final mafiaRoles = item.$3;
                    final freeRoles = item.$4;
                    final isRoleSelected = item.$5;
                    final isCitizenListExpanded = item.$6;
                    final isMafiaListExpanded = item.$7;
                    final isFreeListExpanded = item.$8;
                    // debugPrint('$roles');
                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CustomExpandedTile(
                                  onIconPressed: () => bloc.add(ListHeaderPressed(isCitizenListExpanded ?? false, 1)),
                                  onTap: () => bloc.add(ListHeaderPressed(isCitizenListExpanded ?? false, 1)),
                                  isExpanded: isCitizenListExpanded ?? false,
                                  headerColor: Colors.green,
                                  title: 'Citizen',
                                  controller: bloc.citizenListController,
                                  child: _rolesList(context, citizenRoles, Colors.transparent),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CustomExpandedTile(
                                  onIconPressed: () => bloc.add(ListHeaderPressed(isMafiaListExpanded ?? false, 2)),
                                  onTap: () => bloc.add(ListHeaderPressed(isMafiaListExpanded ?? false, 2)),
                                  isExpanded: isMafiaListExpanded ?? false,
                                  headerColor: Colors.red,
                                  title: 'Mafia',
                                  controller: bloc.mafiaListController,
                                  child: _rolesList(context, mafiaRoles, Colors.transparent),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CustomExpandedTile(
                                  onIconPressed: () => bloc.add(ListHeaderPressed(isFreeListExpanded ?? false, 3)),
                                  onTap: () => bloc.add(ListHeaderPressed(isFreeListExpanded ?? false, 3)),
                                  isExpanded: isFreeListExpanded ?? false,
                                  headerColor: Colors.orange,
                                  title: 'Free',
                                  controller: bloc.freePlayerListController,
                                  child: _rolesList(context, freeRoles, Colors.transparent),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SafeArea(
                            top: false,
                            child: BlocSelector<RoleListBloc, RoleListState,
                                    (List<PlayerRole>?, RoleListStatus?, int?)>(
                                selector: (state) =>
                                    (state.selectedRoleList, state.status, state.selectedPlayerRolesTotalCount),
                                builder: (context, item) {
                                  final selectedRoleList = item.$1;
                                  final status = item.$2;
                                  final selectedPlayerRolesTotalCount = item.$3;
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomElevatedButton(
                                            backgroundColor: CustomColor.customGreen,
                                            title: 'Assign Roles',
                                            onPressed: () {
                                              // Function to keep only the selected ones
                                              // context.read<RoleListBloc>().add(SelectedPlayerListCreated());
                                              // Future.delayed(Duration(seconds: 2));
                                              if (status == RoleListStatus.loaded &&
                                                  (selectedPlayerRolesTotalCount != null &&
                                                      selectedPlayerRolesTotalCount > 0)) {
                                                final bloc = context.read<RoleListBloc>();

                                                showDialog(
                                                  // barrierDismissible: false,
                                                  context: context,
                                                  builder: (BuildContext dialogContext) {
                                                    return BlocProvider.value(
                                                        value: bloc,
                                                        child: BlocSelector<RoleListBloc, RoleListState,
                                                                (List<PlayerRole>?, RoleListStatus?, int?)>(
                                                            selector: (state) => (
                                                                  state.selectedRoleList,
                                                                  state.status,
                                                                  state.selectedPlayerRolesTotalCount
                                                                ),
                                                            builder: (context, item) {
                                                              final selectedPlayerRolesTotalCount = item.$3;
                                                              return Dialog(
                                                                  backgroundColor: CustomColor.backGroundColor,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Card(
                                                                        color: Colors.black.withOpacity(0.5),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(8.0),
                                                                          child: Text(
                                                                            'No of Players: ${players.length}',
                                                                            style: TextStyle(color: Colors.yellow),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child: ListView.builder(
                                                                            physics: const BouncingScrollPhysics(
                                                                                parent:
                                                                                    AlwaysScrollableScrollPhysics()),
                                                                            shrinkWrap: true,
                                                                            itemCount: selectedRoleList?.length,
                                                                            itemBuilder:
                                                                                (BuildContext context, int index) {
                                                                              return Card(
                                                                                color: Colors.black.withOpacity(0.5),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                      horizontal: 8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                          child: Text(
                                                                                        selectedRoleList![index]
                                                                                            .roleName!,
                                                                                        style: TextStyle(
                                                                                            color: Colors.yellow),
                                                                                      )),
                                                                                      Row(
                                                                                        children: [
                                                                                          IconButton(
                                                                                              onPressed: () {
                                                                                                bloc.add(
                                                                                                    DecreaseRoleCountPressed(
                                                                                                        index));
                                                                                                // setState(() {});
                                                                                              },
                                                                                              icon: const Icon(
                                                                                                Icons.remove,
                                                                                                color: Colors.yellow,
                                                                                              )),
                                                                                          Text(
                                                                                            '${selectedRoleList[index].count!}',
                                                                                            style: TextStyle(
                                                                                                color: Colors.yellow),
                                                                                          ),
                                                                                          IconButton(
                                                                                              onPressed: () {
                                                                                                bloc.add(
                                                                                                    IncreaseRoleCountPressed(
                                                                                                        index));
                                                                                                // setState(() {});
                                                                                              },
                                                                                              icon: const Icon(
                                                                                                Icons.add,
                                                                                                color: Colors.yellow,
                                                                                              ))
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                    backgroundColor:
                                                                                        WidgetStateProperty.all(
                                                                                            CustomColor.customRed)),
                                                                                child: const Text(
                                                                                  'Cancel',
                                                                                  style: TextStyle(
                                                                                      fontSize: 15,
                                                                                      color: Colors.yellow),
                                                                                ),
                                                                                onPressed: () => AppRouter.router.pop(),
                                                                                // onPressed: (){
                                                                                //   Navigator.push(
                                                                                //     context,
                                                                                //     MaterialPageRoute(
                                                                                //       builder: (context1) => AssignRolesPage(roleListBloc: context.read<RoleListBloc>(),),
                                                                                //     ),
                                                                                //   );
                                                                                // }
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                    backgroundColor:
                                                                                        WidgetStateProperty.all(
                                                                                            CustomColor.customGreen)),
                                                                                child: Text(
                                                                                  'Total Role: $selectedPlayerRolesTotalCount',
                                                                                  style: const TextStyle(
                                                                                      fontSize: 15,
                                                                                      color: Colors.yellow),
                                                                                ),
                                                                                onPressed: () async =>
                                                                                    await AppRouter.router.push(
                                                                                        PAGES
                                                                                            .assignRolesPage.screenPath,
                                                                                        extra: context
                                                                                            .read<RoleListBloc>()),
                                                                                // onPressed: (){
                                                                                //   Navigator.push(
                                                                                //     context,
                                                                                //     MaterialPageRoute(
                                                                                //       builder: (context1) => AssignRolesPage(roleListBloc: context.read<RoleListBloc>(),),
                                                                                //     ),
                                                                                //   );
                                                                                // }
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ));
                                                            }));
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }))
                      ],
                    );
                  });
            }));
  }

  _rolesList(BuildContext context, List<PlayerRole> playersRole, Color ListBgndColor) {
    return Card(
      elevation: 0,
      color: ListBgndColor,
      child: Center(
        child: Wrap(
          // spacing: 3.0, // Horizontal spacing between items
          // runSpacing: 1.0, // Vertical spacing between rows
          children: List.generate(
            playersRole.length, // Replace with your actual itemCount
            (index) => Container(
              width: MediaQuery.of(context).size.width / 3.2, // Width of each item
              // Height of each item

              child: Card(
                color: Colors.black.withOpacity(0.5),
                child: InkWell(
                  onTap: () {
                    context.read<RoleListBloc>().add(PlayerRoleIsSelected(playersRole[index]));
                    context.read<RoleListBloc>().add(SelectedPlayerListCreated());
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          playersRole[index].roleName ?? '',
                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CustomCheckBox(
                        initialValue: playersRole[index].isSelected!,
                        onChanged: (value) {
                          context.read<RoleListBloc>().add(PlayerRoleIsSelected(playersRole[index]));
                          context.read<RoleListBloc>().add(SelectedPlayerListCreated());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _appbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: BlocSelector<RoleListBloc, RoleListState, bool>(
          selector: (state) => state.isAllSelected ?? false,
          builder: (context, isAllSelected) {
            return AppBar(
              title: Text(isAllSelected ? 'Test' : "Test"),
              backgroundColor: CustomColor.appbarColor,
            );
          }),
    );
  }
}
