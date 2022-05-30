import 'package:tvseries/data/models/spoken_language_model.dart';
import 'package:tvseries/domain/entities/spoken_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tSpokenLanguageModel = SpokenLanguageModel(
    name: 'name',
    code: 'code',
    englishName: 'englishName'
  );

  const tSpokenLanguage = SpokenLanguage(
      name: 'name',
      code: 'code',
      englishName: 'englishName'
  );

  test('should be a subclass of SpokenLanguage entity', () async {
    final result = tSpokenLanguageModel.toEntity();
    expect(result, tSpokenLanguage);
  });
}
