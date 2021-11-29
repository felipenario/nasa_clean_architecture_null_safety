import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture_null_safety/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture_null_safety/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late HttpClient client;
  setUp(() {
    client = HttpClientMock();
    datasource = SpaceMediaDatasouceImplementation(client);
  });
  final tDateTime = DateTime(2021, 11, 27);
  const expectedUrl =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-11-27';
  void successMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('Should call the get method with correct url.', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(expectedUrl)).called(1);
  });

  test('Shoud return a SpaceMediaModel when is successful.', () async {
    // Arrange
    successMock();
    const tSpaceMediaModelExpected = SpaceMediaModel(
        description: 'Description for testing purposes.',
        mediaType: 'image',
        title: 'Testing Title',
        mediaUrl: 'https://mockurl.com/image.jpg');
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModelExpected);
  });

  test('Should throw a ServerException when the call is unccessful.', () async {
    // Arrange
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'Something went wrong', statusCode: 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerException()));
  });
}
