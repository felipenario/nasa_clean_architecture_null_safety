import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
