import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/presentation/controllers/saved_note_controller.dart';
import 'package:my_note/routes/route_name.dart';

class SavedNotePage extends GetView<SavedNoteController> {
  const SavedNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<Box<Note>>(
        valueListenable: Hive.box<Note>('note_storage').listenable(),
        builder: (context, box, _) {
          final noteList = box.values.toList();
          if (noteList.isNotEmpty) {
            return MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.all(8.0),
              mainAxisSpacing: 5,
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () => Get.toNamed(
                      RouteName.savedNotes + '/${noteList[index].id}'),
                  onLongPress: () {
                    Get.defaultDialog(
                      title: 'Remove Note',
                      radius: 10,
                      content: const Text(
                        'This action will remove selected note from database',
                      ),
                      confirm: TextButton(
                        onPressed: () => controller.removeNote(noteList[index]),
                        child: const Text('Remove'),
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.grey.shade100,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noteList[index].title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DateFormat('dd MMM yyyy kk:mm').format(
                              DateTime.parse(noteList[index].updatedAt)
                                  .toLocal(),
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Text(
                            noteList[index].body,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            softWrap: true,
                          ),
                          const SizedBox(height: 15),
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 8,
                            runSpacing: 8,
                            children: List.generate(
                              noteList[index].tags.length,
                              (tagIndex) => Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Text(
                                  '#${noteList[index].tags[tagIndex]}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            key: ValueKey('empty_saved_note'),
            child: Text(
              'Empty Notes',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
