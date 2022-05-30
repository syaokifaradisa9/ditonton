import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/network_channel.dart';

class NetworkChannelModel extends Equatable{
  final int id;
  final String name;
  final String logoPath;
  final String country;

  const NetworkChannelModel({
    required this.id,
    required this.name,
    required this.country,
    required this.logoPath
  });

  factory NetworkChannelModel.fromJson(Map<String, dynamic> json) => NetworkChannelModel(
    id: json['id'],
    name: json['name'],
    country: json['origin_country'],
    logoPath: json['logo_path']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_path': logoPath,
    'origin_country': country,
  };

  NetworkChannel toEntity() => NetworkChannel(
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