import 'package:bits_project/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should forward to the call to InternetConnectionChecker.hasConnection',
        () async {
      final userConnectionFuture = Future.value(true);

      when(() => mockInternetConnectionChecker.hasConnection).thenAnswer((_) {
        return userConnectionFuture;
      });
      final result = networkInfo.isConnected;
      verify(() => mockInternetConnectionChecker.hasConnection);
      expect(result, userConnectionFuture);
    });
  });
}
