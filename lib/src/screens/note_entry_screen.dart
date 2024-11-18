import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplenote/app_styles.dart';
import 'package:simplenote/router.config.dart';
import 'package:simplenote/src/widgets/custom_expandable_container.dart';
import 'package:simplenote/src/widgets/header_tile.dart';
import 'package:simplenote/src/widgets/note_widget.dart';
import 'package:uuid/uuid.dart';
import '../blocs/notes/notes_bloc.dart';
import '../blocs/notes/notes_event.dart';
import '../blocs/notes/notes_state.dart';
import '../models/note.model.dart';
import '../widgets/custom_error.dart';
import '../widgets/custom_floating_action_btn.dart';
import '../widgets/custom_loading.dart';
import '../widgets/custom_loading1.dart';
import '../widgets/custom_textbox.dart';
import '../widgets/navigation_tile.dart';

class NoteEntryScreen extends StatefulWidget {
  final List<NoteModel>? notes;
  final NoteModel? activeNote;
  const NoteEntryScreen(
      {
        super.key,
        required this.notes,
        required this.activeNote,
      });

  @override
  NoteEntryScreenState createState() {
    return NoteEntryScreenState();
  }
}

class NoteEntryArguments {
  final List<NoteModel>? notes;
  final NoteModel? activeNote;
  NoteEntryArguments(this.notes, this.activeNote);
}

class NoteEntryScreenState extends State<NoteEntryScreen> {
  final _noteTitleTextController = TextEditingController();
  final _noteContentTextController = TextEditingController();
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.activeNote != null){
        _noteTitleTextController.text = widget.activeNote!.title.toString();
        _noteContentTextController.text = widget.activeNote!.content.toString();
      }
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
            return notes(context, state);
            // if(state is NotesLoadingState){
            //   return CustomLoading();
            // }
            // else if (state is NotesLoadedState){
            //   return notes(context, state);
            // }
            // else if (state is NotesErrorState){
            //   return CustomError(text: state.message.toString());
            // }
            // else{
            //   return CustomError(text: "No Notes found!");
            // }
          }
      );
  }
  Widget notes(BuildContext context, NotesState state){
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return
        Scaffold(
          backgroundColor: AppStyles.themeColor,
          appBar: const HeaderTile(
              title: "SIMPLE NOTE",
              isHome: false,
          ),
          floatingActionButton:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomFloatingActionButton(
                onPressed: () {
                  NoteModel note = new NoteModel(
                    id: const Uuid().v4(),
                    title: _noteTitleTextController.text.isEmpty ? "Note" : _noteTitleTextController.text,
                    content: _noteContentTextController.text,
                    createdOn: DateTime.now(),
                    updatedOn: DateTime.now(),
                  );
                  if(widget.activeNote != null){
                    note = note.copyWith(
                      id: widget.activeNote!.id,
                      title: _noteTitleTextController.text,
                      content: _noteContentTextController.text,
                      createdOn: widget.activeNote!.createdOn,
                      updatedOn: DateTime.now(),
                    );
                  }

                  if(_noteContentTextController.text.isNotEmpty){
                    context.read<NotesBloc>().add(SaveNoteEvent(note));
                    _noteTitleTextController.text = "";
                    _noteContentTextController.text = "";
                  }
                },
                icon: Icons.save,
                text: widget.activeNote == null ? 'SAVE' : 'UPDATE',
                tooltip: 'Save note',
              ),
            ],
          ),
          body:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // First part: Fixed Stack with CustomTextbox and loading overlay
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Center(
                      child: CustomTextbox(
                      hintText: (state is NotesLoadingState)?  '' : 'Title...',
                      textInputType: TextInputType.text,
                      lines: 1,
                      onSubmitField: () {},
                      controller: _noteTitleTextController,
                      ),
                    ),
                  ),


                  Positioned(
                    top: 60,
                    child: Center(
                      child: CustomTextbox(
                        hintText: (state is NotesLoadingState)?  '' : 'Content...',
                        textInputType: TextInputType.text,
                        lines: 10,
                        onSubmitField: () {},
                        controller: _noteContentTextController,
                      ),
                    ),
                  ),
                  // If loading, display the overlay on top of the textbox
                  if (state is NotesLoadingState)
                    AbsorbPointer(
                      absorbing: true, // Prevent interaction while loading
                      child: SizedBox(
                        width: deviceW,
                        height: deviceH / 3,
                        child: CustomLoading1(), // Your loading widget
                      ),
                    ),
                ],
              ),
              Divider(height: 80, thickness: 80, color: Colors.transparent),
              // Second part: Scrollable list of notes
              Expanded( // This makes sure the scrollable part takes up the remaining space
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      CustomExpandableContainer(
                        verticalSpacing: 10,
                        horizontalSpacing: 10,
                        maxWidth: deviceW,
                        children: [
                          if (state is NotesLoadedState)
                            ...List.generate(
                              state.notes.length,
                                  (index) => NoteWidget(
                                height: 100,
                                width: deviceW - 20,
                                borderColor: widget.activeNote != null &&
                                    widget.activeNote!.id == state.notes[index].id
                                    ? AppStyles.themeColorDarker
                                    : AppStyles.defaultBGColor,
                                fillColor: widget.activeNote != null &&
                                    widget.activeNote!.id == state.notes[index].id
                                    ? AppStyles.themeColorDarker
                                    : AppStyles.defaultBGColor,
                                title: state.notes[index].title.toString(),
                                content: state.notes[index].content.toString(),
                                onTap: (val) {
                                  final args = NoteEntryArguments(state.notes, state.notes[index]);
                                  setState(() {
                                    _noteTitleTextController.text = args.activeNote!.title.toString();
                                    _noteContentTextController.text = args.activeNote!.content.toString();
                                  });

                                  if(widget.activeNote != null && state.notes[index].id == widget.activeNote!.id){
                                    context.go(AppRoutes.noteEntry, extra: NoteEntryArguments(null, null));
                                    _noteTitleTextController.text = "";
                                    _noteContentTextController.text = "";
                                  }
                                  else{
                                    context.go(AppRoutes.noteEntry, extra: args);
                                  }
                                },
                                onDelete: (val){
                                  context.read<NotesBloc>().add(DeleteNoteEvent(state.notes[index].id));
                                  if(widget.activeNote != null){
                                    _noteTitleTextController.text = "";
                                    _noteContentTextController.text = "";
                                  }
                                },
                              ),
                            ),
                        ],
                      ),
                      // If loading, display the overlay on top of the list as well
                      if (state is NotesLoadingState)
                        SizedBox(
                          width: deviceW,
                          height: deviceH / 4,
                          child: CustomLoading1(), // Your loading widget
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 10, thickness: 10, color: Colors.transparent),
            ],
          )
        );
  }
}
