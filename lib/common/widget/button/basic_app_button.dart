import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double?height;
  const BasicAppButton({super.key, required this.onPressed, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(

        minimumSize: Size.fromHeight(height??80)
      ),
      onPressed: onPressed, 
      child: Text(text,style: TextStyle(color: Colors.white),));
  }
}