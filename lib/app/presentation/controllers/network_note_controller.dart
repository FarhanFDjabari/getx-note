import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_note/app/core/network/network_info.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/domain/usecases/add_new_local_note.dart';
import 'package:my_note/app/domain/usecases/get_remote_notes.dart';

enum NetworkNoteViewState { initial, busy, error, data }

class NetworkNoteController extends GetxController {
  final network = GetIt.instance.get<NetworkInfoI>();
  final getAllNotesUsecase = GetIt.instance.get<GetRemoteNotes>();
  final addNewLocalNote = GetIt.instance.get<AddNewLocalNote>();

  final networkNoteViewState = NetworkNoteViewState.initial.obs;
  final connectivityResult = ConnectivityResult.none.obs;

  var noteList = <Note>[].obs;

  @override
  void onInit() async {
    connectivityResult.value = await network.connectivityResult;
    await getAllNotes();
    super.onInit();
    network.onConnectivityChanged.listen((event) {
      connectivityResult.value = event;
      if (event != ConnectivityResult.none) getAllNotes();
    });
  }

  Future<void> getAllNotes() async {
    if (networkNoteViewState.value == NetworkNoteViewState.busy) return;

    if (connectivityResult.value != ConnectivityResult.none) {
      networkNoteViewState(NetworkNoteViewState.busy);
      final _response = await getAllNotesUsecase.execute();

      _response.fold((l) {
        networkNoteViewState(NetworkNoteViewState.error);
        Get.showSnackbar(
          GetSnackBar(
            duration: const Duration(seconds: 2),
            title: 'Error',
            message: l.message,
          ),
        );
      }, (r) {
        networkNoteViewState(NetworkNoteViewState.data);
        noteList.clear();
        noteList.addAll(r);
      });
    } else {
      networkNoteViewState(NetworkNoteViewState.error);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'No Interet Connection',
        ),
      );
    }
  }

  void saveNote(Note note) async {
    final _response = await addNewLocalNote.execute(note);

    if (_response) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Saved',
          message: 'Note successfully saved to database',
        ),
      );
      Get.back(closeOverlays: true);
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          title: 'Database Error',
          message: 'Failed to save note',
        ),
      );
    }
  }
}
