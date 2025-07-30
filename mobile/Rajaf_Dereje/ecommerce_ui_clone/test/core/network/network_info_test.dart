import 'package:ecommerce_ui_clone/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart'; // for GenerateMocks
import 'package:mockito/annotations.dart'; // for GenerateMocks
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker]) // uncomment if a mock class has changed or if you want to add new mock class

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // Arrange
        when(
          mockInternetConnectionChecker.hasConnection,
        ).thenAnswer((_) async => true);

        // Act
        final result = await networkInfo.isConnected;
        // Assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, true);
      },
    );
  }); // isConnection checker group.
}
