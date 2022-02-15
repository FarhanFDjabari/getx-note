import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_note/app/data/datasources/local/note_local_datasources.dart';
import 'package:my_note/app/data/datasources/remote/note_remote_datasources.dart';
import 'package:my_note/app/data/repositories/note_repository_impl.dart';

import '../../helper.dart';
import 'note_repository_impl_test.mocks.dart';

// class NoteLocalDatasourcesMock extends Mock implements NoteLocalDatasources {}

// class NoteRemoteDatasoucesMock extends Mock implements NoteRemoteDatasources {}

@GenerateMocks([NoteLocalDatasources, NoteRemoteDatasources])
void main() {
  late NoteLocalDatasources localDatasources;
  late NoteRemoteDatasources remoteDatasources;
  late NoteRepositoryImpl repositoryImpl;

  setUp(() {
    localDatasources = MockNoteLocalDatasources();
    remoteDatasources = MockNoteRemoteDatasources();
    repositoryImpl = NoteRepositoryImpl(
      localDatasources: localDatasources,
      remoteDatasources: remoteDatasources,
    );
  });

  group('remote notes:', () {
    test(
        'should return notes data when the call to remoteDatasource is successful',
        () async {
      // arrange
      when(remoteDatasources.getNotes())
          .thenAnswer((_) => Future.value(Right(notes)));

      // act
      final result = await repositoryImpl.getRemoteNotes();

      // assert
      expect(result, Right(notes));
      verify(remoteDatasources.getNotes());
      verifyNoMoreInteractions(remoteDatasources);
    });
  });

  group('local notes:', () {
    test('should return true when the data saved to localDatasource', () async {
      // arrange
      when(localDatasources.addNewNote(notes[0]))
          .thenAnswer((realInvocation) => Future.value(true));

      // act
      final result = await repositoryImpl.addNewLocalNote(notes[0]);

      // assert
      expect(result, true);
      verify(localDatasources.addNewNote(notes[0]));
      verifyNoMoreInteractions(localDatasources);
    });
  });
}
