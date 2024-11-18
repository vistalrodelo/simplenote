import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplenote/router.config.dart';
import 'package:simplenote/src/blocs/notes/notes_bloc.dart';

import 'app.config.dart';

final getIt = GetIt.instance;

class SimpleNote extends StatelessWidget {
  const SimpleNote({super.key});
  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return
      MultiBlocProvider(
          providers: [
            BlocProvider(
              create:(context) => NotesBloc(),
            ),
          ],
          child:
          RotatedBox(
            quarterTurns: 0,
            child: MaterialApp.router(
              title: AppConfig.of(context).appBaseConfig.appName,
              debugShowCheckedModeBanner: AppConfig.of(context).appBaseConfig.debug,
              theme: ThemeData(
                fontFamily: GoogleFonts.quicksand.toString(),
                colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Color(0xFF087eff),
                  onPrimary: Color(0xFFFFFFFF),
                  secondary: Color(0xFFA2A2A2),
                  onSecondary: Color(0xFFFFFFFF),
                  error: Color(0xFFBA1A1A),
                  onError: Color(0xFFFFFFFF),
                  surface: Color(0xFFFFFFFF),
                  onSurface: Color(0xFF000000),
                ),
              ),
              routerConfig: routerConfig, // Pass the routerConfig here
            ),
          )
      );
  }
}