import 'package:tvseries/data/models/production_company_model.dart';
import 'package:tvseries/domain/entities/production_company.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProductionCompanyModel = ProductionCompanyModel(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  const tProductionCompany = ProductionCompany(
    name: 'name',
    country: 'country',
    logoPath: 'logoPath',
    id: 'id'
  );

  test('should be a subclass of ProductionCompany entity', () async {
    final result = tProductionCompanyModel.toEntity();
    expect(result, tProductionCompany);
  });
}
