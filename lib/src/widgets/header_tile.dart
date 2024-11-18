import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simplenote/src/widgets/custom_button.dart';

import '../../router.config.dart';

class HeaderTile extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isHome;
  final Function(bool isSelected)? onTap;

  const HeaderTile({
    Key? key,
    this.isHome = true,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  _HeaderTileState createState() => _HeaderTileState();

  @override
  Size get preferredSize => const Size.fromHeight(80); // You can adjust the height as needed
}

class _HeaderTileState extends State<HeaderTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    return Container(
      width: deviceW,
      height: deviceH*0.1,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              !widget.isHome ?
              GestureDetector(
                onTap: () {
                  context.go(AppRoutes.noteshome);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 5),
                  child: Icon(
                    Icons.chevron_left_sharp,
                    size: 35,
                  ),
                ),
              ) : const SizedBox.shrink(),
              const Spacer(),

              Text(
                widget.title,
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              !widget.isHome ? const Spacer() : SizedBox.shrink(),
              //!widget.isHome ?
              // Padding(
              //   padding: const EdgeInsets.only(right: 20),
              //   child: CustomButton(
              //       buttonText: "SAVE",
              //       fontColor: Color(0xFF229922),
              //       fontWeight: FontWeight.w500,
              //       fontSize: 18,
              //       width: 70,
              //       height: 35,
              //       fillColor: Colors.transparent,
              //       elevation: 0,
              //   ),
              // ) : SizedBox.shrink(),
              const Spacer()
            ],
          ),
          const Divider(
            thickness: 10,
            height: 10,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
