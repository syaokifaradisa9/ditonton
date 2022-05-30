import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/network_channel_model.dart';
import 'package:tvseries/domain/entities/network_channel.dart';

void main() {
  const tNetworkChannelModel = NetworkChannelModel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  const tNetworkChannel = NetworkChannel(
    name: 'name',
    id: 1,
    country: 'country',
    logoPath: 'logoPath'
  );

  test('should be a subclass of NetworkChannel entity', () async {
    final result = tNetworkChannelModel.toEntity();
    expect(result, tNetworkChannel);
  });
}
