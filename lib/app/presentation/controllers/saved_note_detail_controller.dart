import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:get_it/get_it.dart';
import 'package:my_note/app/domain/usecases/delete_local_note.dart';
import 'package:my_note/app/domain/usecases/get_local_note_by_id.dart';
import 'package:my_note/app/domain/usecases/update_local_note.dart';

enum SavedNoteDetailViewState { initial, busy, error, data }

class SavedNoteDetailController extends GetxController {
  final getLocalNoteById = GetIt.instance.get<GetLocalNoteById>();
  final updateLocalNote = GetIt.instance.get<UpdateLocalNote>();
  final deleteLocalNote = GetIt.instance.get<DeleteLocalNote>();

  final savedNoteDetailViewState = SavedNoteDetailViewState.initial.obs;

  late TextEditingController titleController;
  late TextEditingController tagController;
  late TextEditingController bodyController;
  var tags = <String>[].obs;
  late Rx<Note> note;

  @override
  void onInit() async {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    tagController = TextEditingController();
    note = Note(
      id: 'test',
      tags: tags,
      title: '',
      body: '',
      createdAt: '',
      updatedAt: '',
    ).obs;
    await fetchNoteData(Get.parameters['id'] ?? '0');
    super.onInit();
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
    }
  }

  Future<void> fetchNoteData(String id) async {
    savedNoteDetailViewState(SavedNoteDetailViewState.busy);
    try {
      final _response = await getLocalNoteById.execute(id);
      note(_response);
      titleController.text = note.value.title;
      bodyController.text = note.value.body;
      tags(note.value.tags);
      savedNoteDetailViewState(SavedNoteDetailViewState.data);
      return;
    } catch (error) {
      savedNoteDetailViewState(SavedNoteDetailViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to fetch note from database',
        ),
      );
    }
  }

  void updateNote(String id) async {
    final updatedNote = note()
      ..id = id
      ..title = titleController.text
      ..tags = tags
      ..body = bodyController.text
      ..updatedAt = DateTime.now().toIso8601String();

    final _response = await updateLocalNote.execute(updatedNote);

    if (_response) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully update note',
        ),
      );
      return;
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to update note',
        ),
      );
    }
  }

  void deleteNote(Note note) async {
    savedNoteDetailViewState(SavedNoteDetailViewState.busy);

    final _response = await deleteLocalNote.execute(note);

    if (_response) {
      savedNoteDetailViewState(SavedNoteDetailViewState.data);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully delete note',
        ),
      );
      Get.back(closeOverlays: true);
      return;
    } else {
      savedNoteDetailViewState(SavedNoteDetailViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to fetch note from database',
        ),
      );
    }
  }
}
