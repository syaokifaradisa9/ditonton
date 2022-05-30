import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/production_company.dart';

class ProductionCompanyModel extends Equatable{
  final String id;
  final String name;
  final String logoPath;
  final String country;

  const ProductionCompanyModel({
    required this.id,
    required this.name,
    required this.country,
    required this.logoPath,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) => ProductionCompanyModel(
    id: json['id'].toString(),
    name: json['name'],
    logoPath: json['logo_path'] ?? '',
    country: json['origin_country']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': country,
  };

  ProductionCompany toEntity() => ProductionCompany(
      id: id,
      name: name,
      country: country,
      logoPath: logoPath
  );

  @override
  List<Object?> get props => [
    id,
    name,
    logoPath,
    country,
  ];
}