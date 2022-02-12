import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hintTitle;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField({
    required this.title,
    required this.hintTitle,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(3),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: Text(title,style: GoogleFonts.cairo(
               fontWeight: FontWeight.bold,fontSize: 18
           ),
             textAlign: TextAlign.start,
           ),
         ),
         Card(
            //shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            elevation:5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      controller: controller,
                      readOnly:widget==null? false:true ,
                      cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                      style:TextStyle(color:Get.isDarkMode?colorWhite: colorBlack),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: hintTitle,
                          hintStyle: GoogleFonts.cairo(
                            color: Get.isDarkMode?colorWhite:colorBlack,
                            textStyle: TextStyle(
                              color: Get.isDarkMode?colorWhite:colorBlack,
                            )
                          ),
                          border: InputBorder.none,focusedBorder: InputBorder.none),
                    ),
                  ),
                  widget?? Container()
                ],
              ),
            ),
          ),
       ],
     ),
   );
  }
}
/*
 return Container(

      margin: const EdgeInsets.only(left: 16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(

          ),),
          Container(
            width: SizeConfig.screenWidth,
            height: 52,
            padding: const EdgeInsets.only(top: 8),
            margin: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:Colors.grey ,
                )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: controller,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText:hintTitle,
                      hintStyle: TextStyle(

                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:BorderSide.none
                      )
                    ),
                  ),
                ),
                widget??Container(),
              ],
            ),
          ),
        ],
      )
    );
 */