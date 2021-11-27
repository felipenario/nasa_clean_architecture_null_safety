import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_architecture_null_safety/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture_null_safety/features/infra/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  const tSpaceMediaModel = SpaceMediaModel(
    description: 'Description for testing purposes.',
    mediaType: 'image',
    title: 'Testing Title',
    mediaUrl: 'https://mockurl.com/image.jpg',
  );

  test('Should be a subclass of SpaceMediaEntity.', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model.', () {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    // Act
    final result = SpaceMediaModel.fromJson(jsonMap);
    // Assert
    expect(result, tSpaceMediaModel);
  });

  test('Should return a json map containing the proper data.', () {
    // Arrange
    final expectedMap = {
      "explanation": "Description for testing purposes.",
      "media_type": "image",
      "title": "Testing Title",
      "url": "https://mockurl.com/image.jpg"
    };
    // Act
    final result = tSpaceMediaModel.toJson();
    // Assert
    expect(result, expectedMap);
  });
}
