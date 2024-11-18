import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_styles.dart';
import '../../router.config.dart';

class CustomError extends StatefulWidget {
  final String? text;
  final bool back;
  CustomError({
    Key? key,
    this.text = "Error!",
    this.back = true,
  }): super(key: key);

  @override
  CustomErrorState createState() {
    return CustomErrorState();
  }
}

class CustomErrorState extends State<CustomError> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool lockLandscape = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final deviceWidth =
    lockLandscape ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;
    final deviceHeight =
    lockLandscape ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    final unitH = deviceHeight*0.001;
    final unitW = deviceWidth*0.001;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(1),
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                Divider(thickness: unitH * 10, color: Colors.transparent,),
                Text(
                  widget.text.toString(),
                  style: GoogleFonts.quicksand(
                    fontSize: (deviceHeight*0.02).round().roundToDouble(),
                    color: AppStyles.themeColor,
                    fontWeight: FontWeight.normal,
                    backgroundColor: Colors.transparent,
                    letterSpacing: 2,
                    height: 1,
                  ),
                ),
                widget.back ?
                TextButton.icon(
                  onPressed: () async {
                    context.go(AppRoutes.noteshome);
                    final _prefs = await SharedPreferences.getInstance();
                    _prefs.clear();
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                  label: Text("Back"),
                ) : SizedBox.shrink(),
              ],
            )
        )
    );
  }
}