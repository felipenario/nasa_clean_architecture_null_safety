import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/failures.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(const SpaceMediaEntity(
            description: '', mediaType: '', mediaUrl: '', title: ''));

  getSpaceMediaFromDate(DateTime? date) async {
    // executeEither(() =>
    //     usecase(date));
    setLoading(true);
    final result = await usecase(date);
    result.fold((error) => setError(error), (success) => update(success));
    setLoading(false);
  }
}
