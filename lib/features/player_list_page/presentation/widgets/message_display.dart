import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String? message;

  const MessageDisplay({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child:  Center(
            child: Text(
              message ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}