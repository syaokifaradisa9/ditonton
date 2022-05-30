import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/production_country.dart';

class ProductionCountryModel extends Equatable{
  final String code;
  final String name;

  const ProductionCountryModel({
    required this.code,
    required this.name,
  });

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) => ProductionCountryModel(
    code: json['iso_3166_1'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'iso_3166_1': code,
    'name': name,
  };

  ProductionCountry toEntity() => ProductionCountry(code: code, name: name);

  @override
  List<Object?> get props =>[
    code,
    name,
  ];
}