import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/spoken_language.dart';

class SpokenLanguageModel extends Equatable{
  final String name;
  final String englishName;
  final String code;

  const SpokenLanguageModel({
    required this.name,
    required this.code,
    required this.englishName,
  });

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) => SpokenLanguageModel(
    code: json['iso_639_1'],
    name: json['name'],
    englishName: json['english_name']
  );

  Map<String, dynamic> toJson() => {
    'iso_639_1': code,
    'name': name,
    'english_name': englishName,
  };

  SpokenLanguage toEntity() => SpokenLanguage(
    name: name,
    code: code,
    englishName: englishName
  );

  @override
  List<Object?> get props => [
    code,
    name,
    englishName,
  ];
}