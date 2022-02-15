import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_note/app/core/errors/failure.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';
import 'package:my_note/app/domain/usecases/get_remote_note_by_id.dart';

import '../../helper.dart';
import 'get_remote_note_by_id_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  late GetRemoteNoteById usecase;
  late NoteRepository noteRepositoryMock;

  setUp(() {
    noteRepositoryMock = MockNoteRepository();
    usecase = GetRemoteNoteById(noteRepositoryMock);
  });

  test('should get remote articles from the repository', () async {
    // arrange
    when(noteRepositoryMock.getRemoteNoteById('sqweaSwqe7'))
        .thenAnswer((realInvocation) => Future.value(Right(notes[0])));

    // act
    final result = await usecase.execute('sqweaSwqe7');

    // assert
    expect(result, Right(notes[0]));
    verify(noteRepositoryMock.getRemoteNoteById('sqweaSwqe7'));
    verifyNoMoreInteractions(MockNoteRepository());
  });

  test('should get failure from the repository', () async {
    const failure = Failure('something went wrong');

    // arrange
    when(noteRepositoryMock.getRemoteNoteById('sqweaSwqe7'))
        .thenAnswer((realInvocation) => Future.value(const Left(failure)));

    // act
    final result = await usecase.execute('sqweaSwqe7');

    // assert
    expect(result, const Left(failure));
    verify(noteRepositoryMock.getRemoteNoteById('sqweaSwqe7'));
    verifyNoMoreInteractions(MockNoteRepository());
  });
}
