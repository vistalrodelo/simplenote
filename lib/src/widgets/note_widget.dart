import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplenote/src/widgets/custom_floating_action_btn.dart';

import '../../app_styles.dart';

class NoteWidget extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final String content;
  final double height;
  final double width;
  final Color isSelectedBorderColor;
  final Color borderColor;
  final double borderRadius;
  final Color fillColor;
  final Color fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double borderWidth;
  final Function(bool isSelected)? onTap;
  final Function(bool isSelected)? onDelete;
  final bool isClickable;
  final bool isOutlined;
  final bool isGradient;
  final Color colorGrade1;
  final Color colorGrade2;
  final double elevation;
  final bool hasButtonImage;
  final String imageAsset;
  final bool hasSuffixChevron;

  NoteWidget(
      {
        Key? key,
        required this.title,
        required this.content,
        this.height = 200.0,
        this.width = 100.0,
        this.borderColor = Colors.transparent,
        this.isSelectedBorderColor = const Color(0xffEBEBEB),
        this.fillColor = AppStyles.themeColor,
        this.fontColor = Colors.black,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 15,
        this.borderWidth = 0.5,
        this.borderRadius = 5.0,
        this.onTap,
        this.onDelete,
        this.iconData,
        this.isClickable = true,
        this.isOutlined = false,
        this.isGradient = false,
        this.colorGrade1 = Colors.transparent,
        this.colorGrade2 = Colors.transparent,
        this.elevation = 0.0,
        this.hasButtonImage = false,
        this.imageAsset = '',
        this.hasSuffixChevron = false,
      });

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isSelected = false;
  bool isMultiSelectItem = false;
  //bool isMultiSelectEnabled = false;
  double _bottom = -10;

  // void _moveMultiSelectionBox() {
  //   setState(() {
  //     _bottom = _bottom == -10 ? 40 : -10;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        elevation: widget.elevation,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderOnForeground: true,
        color: Colors.transparent,
        child: GestureDetector(
          onTap: widget.isClickable
              ? () {
            setState(() {
              isSelected = !isSelected;
              if(isMultiSelectItem){
                isMultiSelectItem = false;
              }
            });
            if (widget.onTap != null) {
              widget.onTap!(isSelected); // Notify parent
            }
          }
          : null,
          onLongPress: widget.isClickable ? () {
                setState(() {
                  isMultiSelectItem = !isMultiSelectItem;
                });
              }
              : null,
          child:
              Stack(
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.isGradient
                            ? [widget.colorGrade1, widget.colorGrade2]
                            : [widget.fillColor, widget.fillColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: widget.isClickable && isSelected
                            ? widget.borderColor
                            : widget.isSelectedBorderColor,
                        width: widget.borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      color: widget.isClickable
                          ? widget.fillColor
                          : AppStyles.defaultButtonColorWithOpacity,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        widget.hasButtonImage
                            ? Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: widget.imageAsset.contains("https")
                              ? SvgPicture.network(
                            widget.imageAsset,
                            width: widget.fontSize * 1.2,
                            height: widget.fontSize * 1.2,
                            fit: BoxFit.cover,
                          )
                              : Image(
                            width: widget.fontSize * 1.2,
                            height: widget.fontSize * 1.2,
                            fit: BoxFit.fitHeight,
                            image: AssetImage(widget.imageAsset),
                          ),
                        )
                            : SizedBox.shrink(),
                        VerticalDivider(
                          thickness: 10,
                          width: 10,
                          color: Colors.transparent,
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 5, right: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.zero,
                                child: SizedBox(
                                    width: widget.width - 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.title,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: (deviceW - 60),
                                  child: Text(
                                    widget.content,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.hasSuffixChevron
                            ? Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            size: 20,
                            widget.iconData != null
                                ? widget.iconData
                                : Icons.chevron_right,
                            color: Colors.white,
                          ),
                        )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  isMultiSelectItem ?
                  Positioned(
                      right: 5,
                      top: 5,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.orange,
                        size: 30,
                      ),
                  ) : SizedBox.shrink(),

                  isMultiSelectItem ?
                  Positioned(
                      right: 40,
                      top: 10,
                      //bottom: _bottom,
                      child: CustomFloatingActionButton(
                          onPressed: (){
                            widget.onDelete!(isMultiSelectItem);
                          },
                          icon: Icons.delete,
                          text: "DELETE",
                          tooltip: "Delete",
                          fillColor: AppStyles.themeColor,
                      ),
                  ) : SizedBox.shrink()
                ],
              )
        ),
      ),
    );
  }
}
