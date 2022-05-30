import 'package:equatable/equatable.dart';

class SpokenLanguage extends Equatable{
  final String name;
  final String englishName;
  final String code;

  const SpokenLanguage({
    required this.name,
    required this.code,
    required this.englishName,
  });

  @override
  List<Object?> get props => [
    code,
    name,
    englishName,
  ];
}