class CommonNoteResponse {
  CommonNoteResponse({
    required this.code,
    required this.status,
    required this.message,
  });

  int code;
  String status;
  String message;

  factory CommonNoteResponse.fromJson(Map<String, dynamic> json) =>
      CommonNoteResponse(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
