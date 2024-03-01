import 'package:flutter/material.dart';
import 'package:god_father/enums/player_list_page_enum.dart';

class DeletePlayerButton extends StatelessWidget {
  PlayerListPageEnum mode;
  DeletePlayerButton({super.key, this.mode = PlayerListPageEnum.view});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Container(),);
  }
}
