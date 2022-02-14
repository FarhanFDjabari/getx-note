class AddNewNoteResponse {
  AddNewNoteResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  String status;
  String message;
  Data data;

  factory AddNewNoteResponse.fromJson(Map<String, dynamic> json) =>
      AddNewNoteResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.noteId,
  });

  String noteId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        noteId: json["noteId"],
      );

  Map<String, dynamic> toJson() => {
        "noteId": noteId,
      };
}
