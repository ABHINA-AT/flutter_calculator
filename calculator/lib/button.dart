import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final VoidCallback? tapped;
  const ButtonWidget({super.key, required this.label, this.color, this.textColor, this.tapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:tapped,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: Container(
          color: color,
          child: Center(
            child: Text(label,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
          ),
          
        ),
      
      ),
    );
  }
}