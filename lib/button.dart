import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final int textColor;
  final int fillColor;
  final double textSize;
  final Function callback;
  const Button(
      {Key key,
      this.text,
      this.textSize = 25,
      this.fillColor,
      this.textColor = 0xFFFFFFFF,
      this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(7),
        child: SizedBox(
            width: 65,
            height: 65,
            child: FlatButton(
              onPressed: () {
                callback(text);
              },
              child: Text(
                text,
                style:
                    GoogleFonts.rubik(textStyle: TextStyle(fontSize: textSize)),
              ),
              color: fillColor != null ? Color(fillColor) : null,
              textColor: Color(textColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            )));
  }
}