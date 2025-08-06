// test/features/authentication/data/datasources/auth_data_source_test.mocks.dart
// (or update your existing mocks file)

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences, Dio])
void main() {} // This main function is just to trigger code generation