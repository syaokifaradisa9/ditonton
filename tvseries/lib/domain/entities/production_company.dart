import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable{
  final String id;
  final String name;
  final String logoPath;
  final String country;

  const ProductionCompany({
    required this.id,
    required this.name,
    required this.country,
    required this.logoPath,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    logoPath,
    country,
  ];
}