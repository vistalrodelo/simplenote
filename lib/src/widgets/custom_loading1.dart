import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_styles.dart';

class CustomLoading1 extends StatefulWidget {
  final String? text;
  CustomLoading1({
    Key? key,
    this.text = "LOADING",
  }): super(key: key);

  @override
  CustomLoading1State createState() {
    return CustomLoading1State();
  }
}

class CustomLoading1State extends State<CustomLoading1> {
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
    return
      Center(
        child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppStyles.textColor,
                    ),
                  ],
                )
            )
        )
      );
  }
}