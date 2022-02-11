import 'package:get/get.dart';
import 'package:my_note/app/bindings/add_note_binding.dart';
import 'package:my_note/app/bindings/home_binding.dart';
import 'package:my_note/app/bindings/note_detail_binding.dart';
import 'package:my_note/app/bindings/saved_note_detail_binding.dart';
import 'package:my_note/app/views/add_note_page.dart';
import 'package:my_note/app/views/home_page.dart';
import 'package:my_note/app/views/network_note_page.dart';
import 'package:my_note/app/views/note_detail_page.dart';
import 'package:my_note/app/views/saved_note_detail_page.dart';
import 'package:my_note/app/views/saved_note_page.dart';
import 'package:my_note/routes/route_name.dart';

class AppRoute {
  static final pages = <GetPage>[
    GetPage(
      name: RouteName.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.networkNotes,
      page: () => const NetworkNotePage(),
    ),
    GetPage(
      name: RouteName.savedNotes,
      page: () => const SavedNotePage(),
    ),
    GetPage(
      name: RouteName.noteDetail,
      page: () => const NoteDetailPage(),
      binding: NoteDetailBinding(),
    ),
    GetPage(
      name: RouteName.savedNoteDetail,
      page: () => const SavedNoteDetailPage(),
      binding: SavedNoteDetailBinding(),
    ),
    GetPage(
      name: RouteName.addNewNote,
      page: () => const AddNotePage(),
      binding: AddNoteBinding(),
    ),
  ];
}
