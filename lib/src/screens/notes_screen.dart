import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplenote/app_styles.dart';
import 'package:simplenote/src/screens/note_entry_screen.dart';
import 'package:simplenote/src/widgets/custom_expandable_container.dart';
import 'package:simplenote/src/widgets/header_tile.dart';
import 'package:simplenote/src/widgets/note_widget.dart';
import '../../router.config.dart';
import '../blocs/notes/notes_bloc.dart';
import '../blocs/notes/notes_event.dart';
import '../blocs/notes/notes_state.dart';
import '../widgets/custom_error.dart';
import '../widgets/custom_floating_action_btn.dart';
import '../widgets/custom_loading.dart';
import '../widgets/navigation_tile.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});
  @override
  NotesScreenState createState() {
    return NotesScreenState();
  }
}

class NotesScreenState extends State<NotesScreen> {
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesBloc>().add(GetNotesEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NotesBloc()..add(GetNotesEvent())),
        ],
        child: MaterialApp(
          home: home(context)
        ),
      );
  }

  Widget home(BuildContext context){
    return
      BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if(state is NotesLoadingState){
              return CustomLoading();
            }
            else if (state is NotesLoadedState){
              return notes(context, state);
            }
            else if (state is NotesErrorState){
              return CustomError(text: state.message.toString());
            }
            else{
              return CustomError(text: "No Notes found!");
            }
          }
      );
  }
  Widget notes(BuildContext context, NotesLoadedState state){
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return
        Scaffold(
          backgroundColor: AppStyles.defaultBGColor,
          appBar: const HeaderTile(
              title: "Simple Notes"
          ),
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              context.go(AppRoutes.noteEntry, extra: NoteEntryArguments(null, null));
            },
            icon: Icons.add,
            text: 'NEW',
            tooltip: 'Add a new note',
          ),
          body:
              SingleChildScrollView(
                  child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Stack(
                      children: [
                        CustomExpandableContainer(
                            verticalSpacing: 10,
                            horizontalSpacing: 10,
                            maxWidth: deviceW,
                            children: List.generate(
                                state.notes.length,
                                    (index) =>
                                    NoteWidget(
                                        width: deviceW-20,
                                        height: 100,
                                        onTap: (val){
                                          final args = NoteEntryArguments(state.notes, state.notes[index]);
                                          context.go(AppRoutes.noteEntry, extra: args);
                                        },
                                        onDelete: (val){
                                          context.read<NotesBloc>().add(DeleteNoteEvent(state.notes[index].id));
                                        },
                                        title: state.notes[index].title.toString(),
                                        content: state.notes[index].content.toString(),
                                    )
                            )
                        ),
                      ]
                  ),
                ),
              )
        );
  }
}
