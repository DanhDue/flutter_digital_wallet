// Copyright (c) 2025, one of the DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/data/local/storage_keys.dart';
import 'package:d3_wallet/data/remote/interceptors/auth_interceptor.dart';
import 'package:d3_wallet/data/repositories/secure_storage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_interceptor_test.mocks.dart';

@GenerateMocks([SecureStorageRepository])
void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MockSecureStorageRepository mockSecureStorage;
  late AuthInterceptor authInterceptor;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
    dioAdapter = DioAdapter(dio: dio);
    mockSecureStorage = MockSecureStorageRepository();
    Get.put<SecureStorageRepository>(mockSecureStorage);
    authInterceptor = AuthInterceptor(dio);
    dio.interceptors.add(authInterceptor);
  });

  tearDown(() {
    Get.reset();
  });

  group('AuthInterceptor', () {
    test('should add Authorization header if token exists', () async {
      // Arrange
      const token = 'test-token';
      when(mockSecureStorage.get(StorageKeys.accessTokenKey)).thenAnswer((_) async => token);

      dioAdapter.onGet('/test', (server) => server.reply(200, {'message': 'success'}));

      // Act
      final response = await dio.get('/test');

      // Assert
      expect(response.requestOptions.headers['Authorization'], 'Bearer $token');
      expect(response.statusCode, 200);
    });

    test('should not add Authorization header if token does not exist', () async {
      // Arrange
      when(mockSecureStorage.get(StorageKeys.accessTokenKey)).thenAnswer((_) async => null);

      dioAdapter.onGet('/test', (server) => server.reply(200, {'message': 'success'}));

      // Act
      final response = await dio.get('/test');

      // Assert
      expect(response.requestOptions.headers.containsKey('Authorization'), isFalse);
    });

    // test('should handle concurrent 401s and refresh only once', () async {
    //   // Note: To test this properly, we'd need to mock the _refreshToken implementation
    //   // or use a real Dio instance for the refresh call.
    //   // For now, this is a conceptual placeholder as the refresh logic itself is a placeholder.
    // });

    // Note: Refresh token logic test is more complex and depends on implementation details
    // which are currently placeholders in the AuthInterceptor.
  });
}
