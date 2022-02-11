import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_note/networking/models/note_model.dart';

class SavedNoteDetailController extends GetxController {
  late Box<Note> savedNoteBox;
  late TextEditingController titleController;
  late TextEditingController tagController;
  var tags = <String>[].obs;
  var isLoading = false.obs;
  late Rx<Note> note;
  late TextEditingController bodyController;

  @override
  void onInit() async {
    savedNoteBox = Hive.box<Note>('note_storage');
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
    isLoading(true);
    try {
      for (var value in savedNoteBox.values) {
        if (id == value.id) {
          note(value);
          titleController.text = note.value.title;
          bodyController.text = note.value.body;
          tags(note.value.tags);
          isLoading(false);
          return;
        }
      }
    } catch (error) {
      isLoading(false);
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

    try {
      for (var value in savedNoteBox.values) {
        if (id == value.id) {
          await savedNoteBox.put(value.key, updatedNote);
          Get.showSnackbar(
            const GetSnackBar(
              duration: Duration(seconds: 2),
              message: 'Successfully update note',
            ),
          );
          return;
        }
      }
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Error',
          message: 'Failed to fetch note from database',
        ),
      );
    }
  }

  void deleteNote(Note note) async {
    isLoading(true);
    try {
      for (var value in savedNoteBox.values) {
        if (note.id == value.id) {
          await value.delete();
          isLoading(false);
          Get.showSnackbar(
            const GetSnackBar(
              duration: Duration(seconds: 2),
              message: 'Successfully delete note',
            ),
          );
          Get.back(closeOverlays: true);
          return;
        }
      }
    } catch (error) {
      isLoading(false);
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
