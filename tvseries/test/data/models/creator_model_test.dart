import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/data/models/creator_model.dart';
import 'package:tvseries/domain/entities/creator.dart';

void main() {
  const tCreatorModel = CreatorModel(
    name: 'name',
    id: 1,
    creditId: 'creditId',
    gender: 1,
    profilePath: 'profilePath'
  );

  const tCreator = Creator(
      name: 'name',
      id: 1,
      creditId: 'creditId',
      gender: 1,
      profilePath: 'profilePath'
  );

  test('should be a subclass of Creator entity', () async {
    final result = tCreatorModel.toEntity();
    expect(result, tCreator);
  });
}
