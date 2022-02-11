import 'package:dio/dio.dart';
import 'package:my_note/networking/models/responses/add_new_note_response.dart';
import 'package:my_note/networking/models/responses/common_note_response.dart';
import 'package:my_note/networking/models/responses/get_all_notes_response.dart';
import 'package:my_note/networking/models/responses/get_note_by_id_response.dart';
import 'package:my_note/networking/models/note_model.dart';
import 'package:retrofit/http.dart';

part 'client.g.dart';

@RestApi(baseUrl: 'https://hapi-note-api.herokuapp.com/')
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET('notes')
  Future<GetAllNotesResponse> getAllNotes();

  @GET('notes/{id}')
  Future<GetNoteByIdResponse> getNoteById(@Path("id") String id);

  @POST('notes')
  Future<AddNewNoteResponse> addNewNote(@Body() Note note);

  @PUT('notes/{id}')
  Future<CommonNoteResponse> editNote(@Path("id") String id, @Body() Note note);

  @DELETE('notes/{id}')
  Future<CommonNoteResponse> deleteNote(@Path("id") String id);
}
