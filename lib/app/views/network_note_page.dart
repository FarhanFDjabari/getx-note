import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_note/app/controllers/network_note_controller.dart';
import 'package:my_note/routes/route_name.dart';

class NetworkNotePage extends GetView<NetworkNoteController> {
  const NetworkNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<NetworkNoteController>(
          init: NetworkNoteController(),
          initState: (_) {},
          builder: (_) {
            if (controller.isLoading.isFalse) {
              if (controller.noteList.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      controller.getAllNotes();
                    });
                  },
                  child: MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    mainAxisSpacing: 5,
                    itemCount: controller.noteList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => Get.toNamed(RouteName.networkNotes +
                                '/${controller.noteList[index].id}')!
                            .then((value) {
                          if (value == true) {
                            controller.getAllNotes();
                          }
                        }),
                        onLongPress: () {
                          Get.defaultDialog(
                            title: 'Save Note',
                            radius: 10,
                            content: const Text(
                              'This action will save selected note to database',
                            ),
                            confirm: TextButton(
                              onPressed: () => controller
                                  .saveNote(controller.noteList[index]),
                              child: const Text('Save'),
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
                                  controller.noteList[index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  DateFormat('dd MMM yyyy HH:mm').format(
                                    DateTime.parse(controller
                                            .noteList[index].updatedAt)
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
                                  controller.noteList[index].body,
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
                                    controller.noteList[index].tags.length,
                                    (tagIndex) => Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Text(
                                        '#${controller.noteList[index].tags[tagIndex]}',
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
                  ),
                );
              }
              return const Center(
                child: Text(
                  'Empty Notes',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.addNewNote)!.then((value) {
          if (value == true) {
            controller.getAllNotes();
          }
        }),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
