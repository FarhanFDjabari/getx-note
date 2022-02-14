import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_note/app/core/network/network_info.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/usecases/add_new_remote_note.dart';

enum AddNoteViewState { initial, busy, error, data }

class AddNoteController extends GetxController {
  final network = GetIt.instance.get<NetworkInfoI>();
  final addNewNoteUsecase = GetIt.instance.get<AddNewRemoteNote>();

  final addNoteViewState = AddNoteViewState.initial.obs;
  final connectivityResult = ConnectivityResult.none.obs;

  late TextEditingController titleController;
  late TextEditingController bodyController;
  late TextEditingController tagController;
  var tags = <String>[].obs;
  var isNoteUploaded = false.obs;

  @override
  void onInit() async {
    addNoteViewState(AddNoteViewState.busy);
    connectivityResult.value = await network.connectivityResult;

    titleController = TextEditingController();
    bodyController = TextEditingController();
    tagController = TextEditingController();
    network.onConnectivityChanged.listen((event) {
      connectivityResult.value = event;
    });
    addNoteViewState(AddNoteViewState.data);
    super.onInit();
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
    }
  }

  void addNewNote() async {
    if (addNoteViewState.value == AddNoteViewState.busy) return;

    if (connectivityResult.value != ConnectivityResult.none) {
      addNoteViewState.value = AddNoteViewState.busy;
      final newNote = Note(
        id: 'dummy',
        title: titleController.text,
        tags: tags,
        body: bodyController.text,
        createdAt: '0',
        updatedAt: '0',
      );

      final _response = await addNewNoteUsecase.execute(newNote);

      _response.fold((l) {
        addNoteViewState(AddNoteViewState.error);
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 2),
            message: 'Failed add note',
          ),
        );
      }, (r) {
        addNoteViewState(AddNoteViewState.data);
        isNoteUploaded(true);
        Get.back(result: true);
        Get.showSnackbar(
          const GetSnackBar(
            duration: Duration(seconds: 2),
            message: 'Successfully add note',
          ),
        );
      });
    } else {
      addNoteViewState(AddNoteViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'No Interet Connection',
        ),
      );
    }
  }
}
