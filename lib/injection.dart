import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_note/app/core/network/network_info.dart';
import 'package:my_note/app/data/api/client.dart';
import 'package:my_note/app/data/datasources/local/note_local_datasources.dart';
import 'package:my_note/app/data/datasources/remote/note_remote_datasources.dart';
import 'package:my_note/app/data/models/note_model.dart';
import 'package:my_note/app/data/repositories/note_repository_impl.dart';
import 'package:my_note/app/domain/repositories/note_repository.dart';
import 'package:my_note/app/domain/usecases/add_new_local_note.dart';
import 'package:my_note/app/domain/usecases/add_new_remote_note.dart';
import 'package:my_note/app/domain/usecases/delete_local_note.dart';
import 'package:my_note/app/domain/usecases/delete_remote_note.dart';
import 'package:my_note/app/domain/usecases/get_local_note_by_id.dart';
import 'package:my_note/app/domain/usecases/get_remote_note_by_id.dart';
import 'package:my_note/app/domain/usecases/get_remote_notes.dart';
import 'package:my_note/app/domain/usecases/update_local_note.dart';
import 'package:my_note/app/domain/usecases/update_remote_note.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton(() => AddNewLocalNote(locator()));
  locator.registerLazySingleton(() => AddNewRemoteNote(locator()));
  locator.registerLazySingleton(() => DeleteLocalNote(locator()));
  locator.registerLazySingleton(() => DeleteRemoteNote(locator()));
  locator.registerLazySingleton(() => GetLocalNoteById(locator()));
  locator.registerLazySingleton(() => GetRemoteNoteById(locator()));
  locator.registerLazySingleton(() => GetRemoteNotes(locator()));
  locator.registerLazySingleton(() => UpdateLocalNote(locator()));
  locator.registerLazySingleton(() => UpdateRemoteNote(locator()));

  locator.registerFactory<NoteRepository>(
    () => NoteRepositoryImpl(
      localDatasources: locator(),
      remoteDatasources: locator(),
    ),
  );

  locator.registerFactory<NoteRemoteDatasources>(
    () => NoteRemoteDatasources(
      client: locator(),
    ),
  );

  locator.registerFactory<NoteLocalDatasources>(() => NoteLocalDatasources());

  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() {
    APIClient client = APIClient(Dio());
    return client;
  });
  locator.registerLazySingleton<NetworkInfoI>(
      () => NetworkInfo(connectivity: locator()));
}
