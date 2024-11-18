import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_styles.dart';

class CustomLoading extends StatefulWidget {
  final String? text;
  CustomLoading({
    Key? key,
    this.text = "LOADING",
  }): super(key: key);

  @override
  CustomLoadingState createState() {
    return CustomLoadingState();
  }
}

class CustomLoadingState extends State<CustomLoading> {
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
    return
      Scaffold(
        body:
        Container(
            width: deviceHeight,
            height: deviceHeight,
            color: Colors.grey.withOpacity(0.6),
            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppStyles.textColor,
                    ),
                    Divider(thickness: unitH * 10, color: Colors.transparent,),
                    Text(
                      widget.text.toString(),
                      style: GoogleFonts.quicksand(
                        fontSize: (deviceHeight*0.02).round().roundToDouble(),
                        color: AppStyles.textColor,
                        fontWeight: FontWeight.normal,
                        backgroundColor: Colors.transparent,
                        letterSpacing: 2,
                        height: 1,
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}