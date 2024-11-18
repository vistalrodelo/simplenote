import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simplenote/src/screens/note_entry_screen.dart';

import '../../router.config.dart';

class NavigationTile extends StatefulWidget implements PreferredSizeWidget {
  final Function(bool isSelected)? onTap;
  final int selectedIndex;

  NavigationTile({
    Key? key,
    this.onTap,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  _NavigationTileState createState() => _NavigationTileState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _NavigationTileState extends State<NavigationTile> {
  late int tab;  // Declare the 'tab' variable

  @override
  void initState() {
    super.initState();
    tab = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    final deviceW = MediaQuery.of(context).size.width;
    final deviceH = MediaQuery.of(context).size.height;
    final unitH = deviceH * 0.01;
    final unitW = deviceW * 0.01;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, //AppStyles.defaultBGColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(unitW * 0), topRight: Radius.circular(unitW * 0)),
      ),
      width: deviceW,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  tab = 1;
                  context.go(AppRoutes.noteshome);
                });
              },
              child: Container(
                color: tab == 1
                    ? Colors.white.withOpacity(0.9) : Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.all(15),
                child: const Icon(
                  Icons.home,
                  color: Colors.pink,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  tab = 2;
                  context.go(AppRoutes.noteEntry, extra: NoteEntryArguments(null, null));
                });
              },
              child: Container(
                color: tab == 2
                    ? Colors.white.withOpacity(0.9) : Colors.grey.withOpacity(0.5),
                padding: EdgeInsets.all(15),
                child: const Icon(
                  Icons.add,
                  color: Colors.pink,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
