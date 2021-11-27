import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;
  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
      description: 'Description for testing purposes.',
      mediaType: 'image',
      title: 'Testing Title',
      mediaUrl: 'https://mockurl.com/image.jpg');

  final tDate = DateTime(2021, 02, 26);

  test('Should get space media entity for a given date from the repository.',
      () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));
    // Act
    final result = await usecase(tDate);
    // Assert
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });

  test('Should return a Failure when don\'t succeed.', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
    // Act
    final result = await usecase(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });
}
