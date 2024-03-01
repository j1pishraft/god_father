import 'package:equatable/equatable.dart';

class Locale extends Equatable{
  final String languageCode;


  const Locale(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}