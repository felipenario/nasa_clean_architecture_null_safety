import 'dart:convert';

import 'package:nasa_clean_architecture_null_safety/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_null_safety/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_architecture_null_safety/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/models/space_media_model.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient client;

  NasaDatasourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
