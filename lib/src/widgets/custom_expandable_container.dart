import 'package:flutter/material.dart';

class CustomExpandableContainer extends StatelessWidget {
  final List<Widget> children;
  final double verticalSpacing;
  final double horizontalSpacing;
  final double maxWidth;

  CustomExpandableContainer({
    required this.children,
    this.verticalSpacing = 2.0,
    this.horizontalSpacing = 2.0,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth,
          ),
          child: Wrap(
            spacing: horizontalSpacing, // Horizontal spacing between children
            runSpacing: verticalSpacing, // Vertical spacing between rows
            children: children.map((child) {
              return IntrinsicWidth(
                child: child,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
