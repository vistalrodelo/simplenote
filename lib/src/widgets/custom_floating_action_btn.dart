import 'package:flutter/material.dart';
import 'package:simplenote/app_styles.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final String tooltip;
  final Color fillColor;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.tooltip,
    this.fillColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        color: fillColor,
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Icon(icon, size: 18),
              ),
              SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
      )
    );
  }
}
