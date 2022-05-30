import 'package:equatable/equatable.dart';

class ProductionCountry extends Equatable{
  final String code;
  final String name;

  const ProductionCountry({
    required this.code,
    required this.name,
  });

  @override
  List<Object?> get props =>[
    code,
    name,
  ];
}