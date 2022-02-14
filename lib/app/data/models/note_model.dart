import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  Note({
    required this.title,
    required this.tags,
    required this.body,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  List<String> tags;
  @HiveField(2)
  String body;
  @HiveField(3)
  String id;
  @HiveField(4)
  String createdAt;
  @HiveField(5)
  String updatedAt;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        body: json["body"],
        id: json["id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "body": body,
        "id": id,
        "updatedAt": updatedAt,
      };
}
