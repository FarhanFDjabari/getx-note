import 'package:my_note/app/data/models/note_model.dart';

class GetNoteByIdResponse {
  GetNoteByIdResponse({
    required this.code,
    required this.status,
    required this.message,
    this.data,
  });

  int code;
  String status;
  String message;
  Data? data;

  factory GetNoteByIdResponse.fromJson(Map<String, dynamic> json) =>
      GetNoteByIdResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
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
    required this.note,
  });

  Note note;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        note: Note.fromJson(json["note"]),
      );

  Map<String, dynamic> toJson() => {
        "note": note.toJson(),
      };
}
