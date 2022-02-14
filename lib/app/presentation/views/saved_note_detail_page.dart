import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_note/app/presentation/controllers/saved_note_detail_controller.dart';

class SavedNoteDetailPage extends GetView<SavedNoteDetailController> {
  const SavedNoteDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GetX<SavedNoteDetailController>(
        init: SavedNoteDetailController(),
        initState: (_) {},
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: controller.savedNoteDetailViewState.value ==
                    SavedNoteDetailViewState.data
                ? SingleChildScrollView(
                    primary: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.titleController,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM yyyy HH:mm').format(
                            DateTime.parse(controller.note.value.updatedAt)
                                .toLocal(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: 1),
                        TextField(
                          controller: controller.bodyController,
                          textInputAction: TextInputAction.newline,
                          textCapitalization: TextCapitalization.sentences,
                          autofocus: false,
                          minLines: 10,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        GetX<SavedNoteDetailController>(
                          init: SavedNoteDetailController(),
                          initState: (_) {},
                          builder: (_) {
                            return Wrap(
                              direction: Axis.horizontal,
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                controller.tags.length,
                                (tagIndex) => InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () => controller.tags.remove(
                                      controller.note.value.tags[tagIndex]),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                    ),
                                    child: Text(
                                      '#${controller.note.value.tags[tagIndex]} \t X',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              width: 70,
                              child: TextField(
                                controller: controller.tagController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  prefixText: '# ',
                                  hintText: 'New tag',
                                ),
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) {
                                  controller.addTag();
                                },
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              onPressed: () => controller.addTag(),
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.add_rounded),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => controller
                                  .updateNote(Get.parameters['id'] ?? 'null'),
                              style: TextButton.styleFrom(
                                primary: Colors.black38,
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              onPressed: () =>
                                  controller.deleteNote(controller.note.value),
                              style: TextButton.styleFrom(
                                primary: Colors.red.shade800,
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
