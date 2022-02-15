import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/data/models/responses/get_all_notes_response.dart'
    as all_n;
import 'package:my_note/app/data/models/responses/get_note_by_id_response.dart'
    as n;

final notes = <Note>[
  Note(
    id: 'sqweaSwqe7',
    title: 'Test Note',
    body: 'This is note',
    tags: ['test', 'note'],
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  ),
];

final getAllNoteResponse = all_n.GetAllNotesResponse(
  code: 200,
  status: 'success',
  message: '',
  data: all_n.Data(notes: notes),
);

final geNoteByIdResponse = n.GetNoteByIdResponse(
  code: 200,
  status: 'success',
  message: '',
  data: n.Data(
    note: notes[0],
  ),
);
