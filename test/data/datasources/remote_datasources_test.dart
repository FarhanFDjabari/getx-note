import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_note/app/data/api/client.dart';
import 'package:my_note/app/data/datasources/remote/note_remote_datasources.dart';

import '../../helper.dart';
import 'remote_datasources_test.mocks.dart';

// class APIClientMock extends Mock implements APIClient {}

@GenerateMocks([APIClient])
void main() {
  late APIClient client;
  late NoteRemoteDatasources remoteDatasources;

  setUp(() {
    client = MockAPIClient();
    remoteDatasources = NoteRemoteDatasources(client: client);
  });

  test('should return articles data when the call to rest client is successful',
      () async {
    when(client.getAllNotes())
        .thenAnswer((_) async => Future.value(getAllNoteResponse));

    final result = await remoteDatasources.getNotes();

    expect(result, Right(notes));
    verify(client.getAllNotes());
    verifyNoMoreInteractions(client);
  });
}
