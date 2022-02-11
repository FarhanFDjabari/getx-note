import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/networking/client/client.dart';
import 'package:my_note/networking/models/note_model.dart';

class AddNoteController extends GetxController {
  final APIClient _client = APIClient(Dio());
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late TextEditingController tagController;
  var tags = <String>[].obs;
  var isLoading = false.obs;
  var isNoteUploaded = false.obs;

  @override
  void onInit() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    tagController = TextEditingController();
    super.onInit();
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
    }
  }

  void addNewNote() async {
    final newNote = Note(
      id: 'dummy',
      title: titleController.text,
      tags: tags,
      body: bodyController.text,
      createdAt: '0',
      updatedAt: '0',
    );

    final _response = await _client.addNewNote(newNote);

    if (_response.status == 'success') {
      isNoteUploaded(true);
      Get.back(result: true);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Successfully add note',
        ),
      );
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Failed add note',
        ),
      );
    }
  }
}
