import 'package:tvseries/data/models/production_country_model.dart';
import 'package:tvseries/domain/entities/production_country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductionCountryModel = ProductionCountryModel(
    name: 'name',
    code: 'code'
  );

  const tProductionCountry= ProductionCountry(
      name: 'name',
      code: 'code'
  );

  test('should be a subclass of ProductionCountry entity', () async {
    final result = tProductionCountryModel.toEntity();
    expect(result, tProductionCountry);
  });
}
