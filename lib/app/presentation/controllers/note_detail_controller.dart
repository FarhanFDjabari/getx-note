import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_note/app/core/network/network_info.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/usecases/delete_remote_note.dart';
import 'package:my_note/app/domain/usecases/get_remote_note_by_id.dart';
import 'package:my_note/app/domain/usecases/update_remote_note.dart';

enum NoteDetailViewState { initial, busy, error, data }

class NoteDetailController extends GetxController {
  final network = GetIt.instance.get<NetworkInfoI>();
  final getRemoteNoteById = GetIt.instance.get<GetRemoteNoteById>();
  final updateRemoteNote = GetIt.instance.get<UpdateRemoteNote>();
  final deleteRemoteNote = GetIt.instance.get<DeleteRemoteNote>();

  final noteDetailViewState = NoteDetailViewState.initial.obs;
  final connectivityResult = ConnectivityResult.none.obs;

  late TextEditingController titleController;
  late TextEditingController tagController;
  late TextEditingController bodyController;
  var tags = <String>[].obs;
  var isNoteUpdated = false.obs;
  late Rx<Note> note;

  @override
  void onInit() async {
    connectivityResult.value = await network.connectivityResult;
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
    network.onConnectivityChanged.listen((event) {
      connectivityResult.value = event;
    });
  }

  void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text);
      tagController.clear();
    }
  }

  Future<void> fetchNoteData(String id) async {
    if (noteDetailViewState.value == NoteDetailViewState.busy) return;

    if (connectivityResult.value != ConnectivityResult.none) {
      noteDetailViewState(NoteDetailViewState.busy);
      final _response = await getRemoteNoteById.execute(id);

      _response.fold(
        (l) {
          noteDetailViewState(NoteDetailViewState.error);
          Get.showSnackbar(
            GetSnackBar(
              duration: const Duration(seconds: 2),
              title: 'Error',
              message: l.message,
            ),
          );
        },
        (r) {
          noteDetailViewState(NoteDetailViewState.data);
          note(r);
          titleController.text = note.value.title;
          bodyController.text = note.value.body;
          tags(note.value.tags);
        },
      );
    } else {
      noteDetailViewState(NoteDetailViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'No Interet Connection',
        ),
      );
    }
  }

  void updateNote(String id) async {
    if (noteDetailViewState.value == NoteDetailViewState.busy) return;

    if (connectivityResult.value != ConnectivityResult.none) {
      noteDetailViewState(NoteDetailViewState.busy);
      final updatedNote = note()
        ..id = id
        ..title = titleController.text
        ..tags = tags
        ..body = bodyController.text
        ..updatedAt = '';

      final _response = await updateRemoteNote.execute(updatedNote);

      _response.fold(
        (l) {
          noteDetailViewState(NoteDetailViewState.error);
          Get.showSnackbar(
            GetSnackBar(
              duration: const Duration(seconds: 2),
              title: 'Error',
              message: l.message,
            ),
          );
        },
        (r) async {
          noteDetailViewState(NoteDetailViewState.data);
          await fetchNoteData(id);
        },
      );
    } else {
      noteDetailViewState(NoteDetailViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'No Interet Connection',
        ),
      );
    }
  }

  void deleteNote(Note note) async {
    if (noteDetailViewState.value == NoteDetailViewState.busy) return;

    if (connectivityResult.value != ConnectivityResult.none) {
      noteDetailViewState(NoteDetailViewState.busy);
      final _response = await deleteRemoteNote.execute(note);

      _response.fold(
        (l) {
          noteDetailViewState(NoteDetailViewState.error);
          Get.showSnackbar(
            GetSnackBar(
              duration: const Duration(seconds: 2),
              title: 'Error',
              message: l.message,
            ),
          );
        },
        (r) {
          noteDetailViewState(NoteDetailViewState.data);
          isNoteUpdated(true);
          Get.showSnackbar(
            const GetSnackBar(
              duration: Duration(seconds: 2),
              message: 'Successfully delete note',
            ),
          );
          Get.back(closeOverlays: true, result: true);
        },
      );
    } else {
      noteDetailViewState(NoteDetailViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'No Interet Connection',
        ),
      );
    }
  }
}
