import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, required this.screenDivision, required this.background, required this.onPressed});
  final String text;
  final int screenDivision;
  final Color background;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40)/screenDivision,
      height: (MediaQuery.of(context).size.height-70)*2/15,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          )
        ),
        child: Text(
            text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width/18,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
