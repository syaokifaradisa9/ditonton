import 'package:equatable/equatable.dart';

class NetworkChannel extends Equatable{
  final int id;
  final String name;
  final String logoPath;
  final String country;

  const NetworkChannel({
    required this.id,
    required this.name,
    required this.country,
    required this.logoPath
  });

  @override
  List<Object?> get props => [
    id,
    name,
    logoPath,
    country,
  ];
}