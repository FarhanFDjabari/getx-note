import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_note/app/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

// class ConnectivityMock extends Mock implements Connectivity {}

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoI networkInfo;
  late Connectivity connectivity;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = NetworkInfo(connectivity: connectivity);
  });

  group('connection test', () {
    test(
      'should call Connectivity.checkConnectivity and return true if result is wifi / mobile, else return false',
      () async {
        when(connectivity.checkConnectivity())
            .thenAnswer((_) async => Future.value(ConnectivityResult.wifi));

        final result = await networkInfo.isConnected();

        verify(connectivity.checkConnectivity());
        expect(result, true);
      },
    );
  });
}
