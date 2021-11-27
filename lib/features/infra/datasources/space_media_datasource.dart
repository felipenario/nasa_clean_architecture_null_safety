import 'package:nasa_clean_architecture_null_safety/features/infra/models/space_media_model.dart';

abstract class ISpaceMediaDatasource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
