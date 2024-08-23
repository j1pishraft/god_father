import 'package:flutter/material.dart';

import '../../../player_list_page/domain/entities/player_entity.dart';

class ShowPlayerRoles extends StatelessWidget {
  final List<Player> players;
  const ShowPlayerRoles({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (BuildContext context, int index) {
            // if (!playersWithRole![index].isVisible) {
            //   return Container(height: 50,); // Return an empty widget for invisible items
            // }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.green,
                title: Row(
                  children: [
                    Expanded(child: Text(players[index].name, style: TextStyle(fontSize: 20),)),
                    Expanded(child: Text(players[index].playerRole!.roleName!, style: TextStyle(fontSize: 20),)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
