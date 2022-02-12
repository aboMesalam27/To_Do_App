import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/services/theme_services.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  // const NotificationScreen({Key? key}) : super(key: key);
  final String payLoad;
  NotificationScreen({required this.payLoad});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String payLoad = "";
  @override
  void initState() {
    payLoad = widget.payLoad;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          payLoad.toString().split("|")[1],
          style: TextStyle(color: Get.isDarkMode ? colorWhite : colorBlack),
        ),
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode?colorWhite:darkGreyClr,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  'Hello,Hassan',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Get.isDarkMode ? colorWhite : darkGreyClr),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'you have a new remind',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.text_format,
                          size: 35,
                          color: colorWhite,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(color: colorWhite, fontSize: 26),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      payLoad.toString().split('|')[0],
                      style: const TextStyle(color: colorWhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.description,
                          size: 35,
                          color: colorWhite,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Description',
                          style: TextStyle(color: colorWhite, fontSize: 26),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      payLoad.toString().split('|')[1],
                      style: const TextStyle(
                        color: colorWhite,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 35,
                          color: colorWhite,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Date',
                          style: TextStyle(color: colorWhite, fontSize: 26),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      payLoad.toString().split('|')[2],
                      style: const TextStyle(color: colorWhite, fontSize: 20),
                    ),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryClr),
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
