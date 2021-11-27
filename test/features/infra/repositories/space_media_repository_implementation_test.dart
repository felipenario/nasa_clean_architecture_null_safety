import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/models/space_media_model.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description: 'Description for testing purposes.',
    mediaType: 'image',
    title: 'Testing Title',
    mediaUrl: 'https://mockurl.com/image.jpg',
  );

  final tDate = DateTime(2021, 02, 26);

  test('Should return space media model when calls the datasource.', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
  });

  test(
      'Should return a ServerFailure when the call to datasource is unsucessfull.',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate));
  });
}
