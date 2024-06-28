import 'package:flutter/material.dart';

class RoleListPage extends StatelessWidget {
  const RoleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar: AppBar(title: Text('test'),backgroundColor: Colors.white,), body: const Center(child: Text('data',style: TextStyle(color: Colors.black, fontSize: 40),),));
  }
}
