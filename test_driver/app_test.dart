import 'dart:io';
import 'package:flutter_test/flutter_test.dart' as test;
import 'package:path/path.dart';

import 'package:flutter_driver/flutter_driver.dart';

const path = r'D:\Users\MSI\AppData\Local\Android\Sdk';

Future<void> grantPermissions() async {
  final adbPath = join(
    path,
    'platform-tools',
    Platform.isWindows ? 'adb.exe' : 'adb',
  );
  await Process.run(
      adbPath, ['shell', 'pm', 'grant', 'android.permission.INTERNET']);
}

void main() {
  test.group('GetX Note App Test', () {
    FlutterDriver? driver;

    // Connect to the Flutter driver before running any tests.
    test.setUpAll(() async {
      // grant device permission
      await grantPermissions();
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    test.tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test.test('verifies the note view and saved note view', () async {
      final appBarFinder = find.byValueKey('home_appbar');
      final emptyNoteFinder = find.byValueKey('empty_note');
      final savedNoteTabFinder = find.byValueKey('saved_note_tab');
      final savedEmptyNoteFinder = find.byValueKey('empty_saved_note');

      await driver!.waitFor(appBarFinder);
      await driver!.waitFor(emptyNoteFinder);
      await driver!.waitForTappable(savedNoteTabFinder);

      await driver!.tap(savedNoteTabFinder);

      await driver!.tap(savedEmptyNoteFinder);
    });
  });
}
