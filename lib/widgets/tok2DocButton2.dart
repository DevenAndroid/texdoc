
import 'package:flutter/material.dart';
import 'package:texdoc/resources/app_theme.dart';

class Tok2DocButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed; // add this
  const Tok2DocButton2(this.buttonText, this.onPressed,); // change this

  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return SizedBox(
      width: deviceWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(primary: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
          elevation: 15.0,),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(buttonText, style: const TextStyle(fontSize: 20),),),),
    );
  }
}