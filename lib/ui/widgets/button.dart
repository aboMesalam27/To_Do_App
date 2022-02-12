import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  final label;
  final Function() onTap;

  MyButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width:100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:primaryClr
        ),
        child: Text(label,style:const  TextStyle(
          color: colorWhite,

        ),
        textAlign: TextAlign.center,),
      ),
    );
  }
}
