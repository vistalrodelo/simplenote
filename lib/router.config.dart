import 'package:go_router/go_router.dart';
import 'package:simplenote/src/screens/note_entry_screen.dart';
import 'package:simplenote/src/screens/notes_screen.dart';

class AppRoutes {
  static const String noteshome = '/';
  static const String noteEntry = '/noteentry';
}

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      name: 'notes',
      path: AppRoutes.noteshome,
      builder: (_, __) => const NotesScreen(),
    ),
    GoRoute(
      name: 'noteentry',
      path: AppRoutes.noteEntry,
      builder: (context, state) {
        var args = state.extra as NoteEntryArguments;
        return NoteEntryScreen(notes: args.notes, activeNote: args.activeNote,);
      },
    ),
  ],
  initialLocation: AppRoutes.noteshome,
);