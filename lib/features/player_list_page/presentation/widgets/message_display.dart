import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String? message;
  final String defaultMessage;

  const MessageDisplay({super.key, required this.message, required this.defaultMessage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message ?? defaultMessage ?? '',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}