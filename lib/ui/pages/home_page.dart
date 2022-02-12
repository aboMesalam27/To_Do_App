import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  var dateTodat = DateFormat.yMMMd().format(DateTime.now()).toString();
  DateTime _selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
    //widget._taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          title:  Text('ToDo',
            style: TextStyle(
              color: Get.isDarkMode?colorWhite:colorBlack
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
              size: 24,
              color: Get.isDarkMode ? colorWhite : darkGreyClr,
            ),
            onPressed: () {
              ThemeServices().switchTheme();
              // notifyHelper.displayNotification(
              //     title: 'Theme Changed!', body: "Tap to shows hints");
              // //notifyHelper.scheduledNotification();
            },
            color: Get.isDarkMode ? primaryClr : darkGreyClr,
          ),
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                AwesomeDialog(
                  btnCancelText: 'No'.tr,
                  btnOkText: 'Yes'.tr,
                  btnOkColor: Colors.red,
                  btnCancelColor:primaryClr,                          context: context,
                  dialogType: DialogType.NO_HEADER,
                  borderSide:
                  const BorderSide(color: Colors.white, width: 2),
                  width: 380,
                  buttonsBorderRadius:
                  const BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.LEFTSLIDE,
                  title: 'INFO'.tr,
                  desc: 'Do You Want To Delete All Tasks'.tr,
                  showCloseIcon: false,
                  btnCancelOnPress: () {
                    //Navigator.pop(context);
                  },
                  btnOkOnPress: () async {
                    widget._taskController.deleteAllTask();
                  },
                ).show();
              },
              icon: const Icon(
                Icons.delete,
              ),
              color: Colors.red,
            ),
           const  SizedBox(
              width: 10,
            ),

            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/person.jpeg'),
                radius: 20,
              ),
            ),

          ],
        ),
        body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            const SizedBox(
              height: 6,
            ),
            _showTasks(),
          ],
        ));
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dateTodat,
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                'Today',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          MyButton(
              label: ' + Add Task',
              onTap: () async {
                await Get.to(const AddTaskPage());
                widget._taskController.getTask();
              })
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(left: 20, top: 6),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: widget._selectedDate,
        selectedTextColor: colorWhite,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.cairo(
            fontSize: 13, fontWeight: FontWeight.w600, color: colorGry),
        dayTextStyle: GoogleFonts.cairo(
            fontSize: 16, fontWeight: FontWeight.w600, color: colorGry),
        monthTextStyle: GoogleFonts.cairo(
            fontSize: 12, fontWeight: FontWeight.w600, color: colorGry),
        onDateChange: (newDate) {
          setState(() {
            widget._selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    widget._taskController.getTask();
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (widget._taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: widget._taskController.taskList.length,
              itemBuilder: (BuildContext context, int index) {
                var task = widget._taskController.taskList[index];

                if ((task.repeat == 'Daily' ||
                    task.date ==
                        DateFormat.yMd().format(widget._selectedDate))) {
                  var hour = task.startTime.toString().split(':')[0];
                  var minutes = task.startTime.toString().split(':')[1];

                  debugPrint(hour);
                  debugPrint(minutes);
                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('HH:mm').format(date);

                  notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1175),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else if (task.repeat == 'Weekly' &&
                    widget._selectedDate
                                .difference(DateFormat.yMd().parse(task.date!))
                                .inDays %
                            7 ==
                        0) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1175),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                }
                // ignore: unrelated_type_equality_checks
                else if (task.repeat == 'Monthly' &&
                    DateFormat.yMd().parse(task.date!).day ==
                        widget._selectedDate.day) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1175),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('');
                }
              },
            ),
          );
        }
      }),
    );
  }

  // return Expanded(
  //   child: GestureDetector(
  //     onTap: () {
  //       _showBottomSheet(
  //           context,
  //           Task(
  //             id: 5,
  //             color: 2,
  //             date: '',
  //             endTime: '2:40',
  //             isCompleted: 0,
  //             note: 'xsdfghjkhgfdfghj',
  //             remind: 4,
  //             repeat: 'None',
  //             startTime: '4:50PM',
  //             title: 'Ali',
  //           ));
  //     },
  //     child: TaskTile(Task(
  //       id: 5,
  //       color: 2,
  //       date: '',
  //       endTime: '2:40',
  //       isCompleted: 0,
  //       note: 'xsdfghjkhgfdfghj',
  //       remind: 4,
  //       repeat: 'None',
  //       startTime: '4:50PM',
  //       title: 'Ali',
  //     )),
  //   ),
  //
  // );
  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 5),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 6)
                      : const SizedBox(height: 200),
                  SvgPicture.asset(
                    'images/task.svg',
                    semanticsLabel: 'Task',
                    height: 100,
                    color: primaryClr.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      'You do not have any task yet!\nAdd new task to make your days productive',
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(height: 120)
                      : const SizedBox(height: 180),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildBottomSheet({
    required String lable,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: isClose
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : clr),
            borderRadius: BorderRadius.circular(20),
            color: isClose ? Colors.transparent : clr),
        child: Center(
          child: Text(
            lable,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: colorWhite,
                  ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkGreyClr : colorWhite,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      lable: 'Task Completed',
                      onTap: () {
                        notifyHelper.deleteNotification(task.id!.toInt());
                        widget._taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: primaryClr,
                    ),
              _buildBottomSheet(
                lable: 'Delete Task ',
                onTap: () {
                  notifyHelper.deleteNotification(task.id!.toInt());
                  widget._taskController.delete(task);
                  Get.back();
                },
                clr: Colors.red,
              ),
              Divider(
                color: Get.isDarkMode ? colorGry : darkGreyClr,
              ),
              _buildBottomSheet(
                lable: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
