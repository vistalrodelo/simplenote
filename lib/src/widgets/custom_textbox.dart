
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplenote/app_styles.dart';

import 'custom_loading1.dart';

class CustomTextbox extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;
  final TextInputAction actionKeyboard;
  final List<TextInputFormatter>? inputFormatter;
  final Function onSubmitField;
  final int lines;
  final TextEditingController controller;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final bool? isEnabled;
  final TextCapitalization textCapitalization;
  final bool isRequired;
  final int? maxLength;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomTextbox(
      {super.key, required this.hintText,
        required this.textInputType,
        this.obscureText = false,
        this.lines = 1,
        this.actionKeyboard = TextInputAction.next,
        this.inputFormatter,
        required this.onSubmitField,
        required this.controller,
        this.onTap,
        this.onEditingComplete,
        this.isEnabled = true,
        this.textCapitalization = TextCapitalization.none,
        this.isRequired = false,
        this.maxLength = 10000,
        this.validator,
        this.focusNode,
      });

  @override
  _CustomTextboxState createState() => _CustomTextboxState();
}

class _CustomTextboxState extends State<CustomTextbox> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: deviceW,
        height: deviceH/3,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppStyles.defaultButtonColorWithOpacity,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(5),
          color: AppStyles.themeColor,
        ),
        child: TextFormField(
            textCapitalization: widget.textCapitalization,
            enabled: widget.isEnabled,
            maxLength: widget.maxLength,
            onTap: widget.onTap,
            onEditingComplete: widget.onEditingComplete,
            maxLines: widget.lines,
            minLines: widget.lines,
            cursorColor: const Color(0xFFAAAAAA),
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType,
            textInputAction: widget.actionKeyboard,
            inputFormatters: widget.inputFormatter,
            validator: widget.validator,
            focusNode: widget.focusNode,
            style: GoogleFonts.nunito(
              color: AppStyles.textColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              letterSpacing: 1,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              counterText: "",
              filled: true,
              fillColor: widget.isEnabled! ?  AppStyles.inputFillColor : const Color(0xFFd5d5d5),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppStyles.defaultBGColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 0
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 0
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(5.0),
                  gapPadding: 0
              ),
              errorStyle: GoogleFonts.nunito(
                  color: Colors.deepOrange,
                  fontSize: 12
              ),
              hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontFamily: 'nunito',
                letterSpacing: 1,
              ),
              contentPadding: EdgeInsets.only(
                top: 10,
                bottom: bottomPaddingToError,
                left: 10.0,
                right: 10.0,
              ),
              isDense: true,
            ),
            controller: widget.controller,
            onFieldSubmitted: (value) {
              widget.onSubmitField();
            },
          )
      );
  }
}