import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_architecture_null_safety/core/http_client/http_implementation.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_architecture_null_safety/features/presenter/controllers/home_store.dart';
import 'package:nasa_clean_architecture_null_safety/features/presenter/pages/home_page.dart';
import 'package:nasa_clean_architecture_null_safety/features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i())),
    Bind((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind((i) => SpaceMediaRepositoryImplementation(i())),
    Bind((i) => SpaceMediaDatasouceImplementation(i())),
    Bind((i) => HttpImplementation()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
