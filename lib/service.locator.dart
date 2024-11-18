import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplenote/src/blocs/notes/notes_bloc.dart';
import 'package:simplenote/src/services/mock_client.dart';
import 'package:simplenote/src/services/note.service.dart';
final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  //register utility services
  // final cacheService = await CacheService.getInstance();
  // getIt.registerSingleton<CacheService>(cacheService);

  // Initialize SharedPreferences asynchronously
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Register SharedPreferences with GetIt
  getIt.registerSingleton<SharedPreferences>(prefs);

  //register services
  getIt.registerLazySingleton<MockClient>(() => MockClient(prefs));
  getIt.registerLazySingleton<NoteService>(() => NoteService(prefs));

  //register blocs
  getIt.registerFactory(() => NotesBloc());
}
