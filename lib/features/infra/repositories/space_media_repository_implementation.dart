import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
