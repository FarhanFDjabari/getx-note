import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_note/networking/client/client.dart';
import 'package:my_note/networking/models/note_model.dart';

class NoteDetailController extends GetxController {
  final APIClient _client = APIClient(Dio());
  late Box<Note> savedNoteBox;
  late TextEditingController titleController;
  late TextEditingController tagController;
  var tags = <String>[].obs;
  var isLoading = false.obs;
  var isNoteUpdated = false.obs;
  late Rx<Note> note;
  late TextEditingController bodyController;

  @override
  void onInit() async {
    savedNoteBox = Hive.box<Note>('note_storage');
    titleController = TextEditingController();
    tagController = TextEditingController();
    bodyController = TextEditingController();
    note = Note(
      id: 'test',
      tags: [],
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
    isLoading(true);
    final _response = await _client.getNoteById(id);

    if (_response.status == 'success') {
      note(_response.data!.note);
      titleController.text = note.value.title;
      bodyController.text = note.value.body;
      tags(note.value.tags);
      isLoading(false);
    } else {
      isLoading(false);
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          title: 'Error ${_response.code}',
          message: 'Failed to fetch note from API',
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
      ..updatedAt = '';

    final _response = await _client.editNote(id, updatedNote);

    if (_response.status == 'success') {
      await fetchNoteData(id);
    } else {
      isLoading(false);
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          title: 'Error ${_response.code}',
          message: 'Failed to fetch note from API',
        ),
      );
    }
  }

  void deleteNote(Note note) async {
    isLoading(true);
    final _response = await _client.deleteNote(note.id);
    if (_response.status == 'success') {
      if (await checkSavedNote(note)) {
        for (var value in savedNoteBox.values) {
          if (note.id == value.id) {
            note.delete();
            break;
          }
        }
      }
      isLoading(false);
      isNoteUpdated(true);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully delete note',
        ),
      );
      Get.back(closeOverlays: true, result: true);
    } else {
      isLoading(false);
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          title: 'Error ${_response.code}',
          message: 'Failed to fetch note from API',
        ),
      );
    }
  }

  Future<bool> checkSavedNote(Note value) async {
    for (var note in savedNoteBox.values) {
      if (value.id == note.id) {
        return true;
      }
    }
    return false;
  }
}
