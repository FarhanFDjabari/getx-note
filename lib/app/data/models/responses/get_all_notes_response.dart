// To parse this JSON data, do
//
//     final getAllNotesResponse = getAllNotesResponseFromJson(jsonString);

import 'package:my_note/app/data/models/note_model.dart';

class GetAllNotesResponse {
  GetAllNotesResponse({
    required this.code,
    required this.status,
    required this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data? data;

  factory GetAllNotesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllNotesResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.notes,
  });

  List<Note> notes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
      };
}
