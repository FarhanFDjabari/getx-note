import 'package:equatable/equatable.dart';

class Note extends Equatable {
  const Note({
    required this.title,
    required this.tags,
    required this.body,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  final String title;
  final List<String> tags;
  final String body;
  final String id;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object?> get props => [title, tags, id, body, createdAt, updatedAt];
}
