import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

   DateTime _selectedDate = DateTime.now();
   String _startTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString();
   String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
          onPressed: () {
            Get.back();
          },
          color: primaryClr,
        ),
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/person.jpeg'),
              radius: 20,
            ),
          ),

        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Text(
                'Add Task',
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, fontSize: 20
                ),
              ),
              InputField(
                controller: _titleController,
                title: 'Title',
                hintTitle: 'Enter title here',
                // widget: Icon(Icons.arrow_back_ios),
              ),
              InputField(
                controller: _noteController,
                title: 'Note',
                hintTitle: 'Enter note here',
                // widget: Icon(Icons.arrow_back_ios),
              ),
              InputField(
                title: 'Date',
                hintTitle: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
                // widget: Icon(Icons.arrow_back_ios),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hintTitle: _startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getStartTimeFromUser();
                        },
                      ),
                      // widget: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hintTitle: _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getEndTimeFromUser();
                        },
                      ),
                      // widget: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  hintTitle: '$_selectedRemind minutes early',
                  widget: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.blueGrey,
                    items: remindList
                        .map<DropdownMenuItem<String>>(
                            (int val) => DropdownMenuItem<String>(
                                value: val.toString(),
                                child: Text(
                                  '$val',
                                  style: const TextStyle(color: colorWhite),
                                )))
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32.0,
                    elevation: 4,
                    underline: Container(
                      height: 0,
                    ),
                    style: const TextStyle(color: Colors.yellow),
                    onChanged: (String? newVal) {
                      setState(() {
                        _selectedRemind = int.parse(newVal!);
                      });
                    },
                  )
                  // widget: Icon(Icons.arrow_back_ios),
                  ),
              InputField(
                  title: 'Repeat',
                  hintTitle: _selectedRepeat,
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    items: repeatList
                        .map<DropdownMenuItem<String>>(
                            (String val) => DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  '$val',
                                  style: const TextStyle(color: colorWhite),
                                )))
                        .toList(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    iconSize: 32.0,
                    elevation: 4,
                    underline: Container(
                      height: 0,
                    ),
                    style: const TextStyle(color: Colors.yellow),
                    onChanged: (String? newVal) {
                      setState(() {
                        _selectedRepeat = newVal!;
                      });
                    },
                  )
                  // widget: Icon(Icons.arrow_back_ios),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPaletee(),
                  MyButton(
                    label: 'Create Task',
                    onTap: () {
                      _validateDate();
                      // Get.back();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addTasksRODb() async {
    try{
      int value = await _taskController.addTSK(
        task: Task(
          title: _titleController.text,
          note: _noteController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
        ),
      );
      print('$value');
    }catch(e){
      print(e);
    }
  }



  _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty)
      {
        _addTasksRODb();
        Get.back();
      }
    else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar(
        'required!',
        'All Fields are required',
        snackPosition: SnackPosition.BOTTOM,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_sharp,color: colorRed,),
        borderRadius: 25,
        duration:const Duration(milliseconds: 3522),

      );
    }
    else{
      print('ghj');
    }
  }

  Column _colorPaletee() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Wrap(
            children: List<Widget>.generate(
          3,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: CircleAvatar(
                radius: 17,
                child: index == _selectedColor
                    ? const Icon(
                        Icons.done,
                        size: 16,
                        color: colorWhite,
                      )
                    : null,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : orangeClr,
              ),
            ),
          ),
        ))
      ],
    );
  }
  
  
  
  

   _getDateFromUser() async{
    DateTime? _pickedDate=await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if(_pickedDate==null){
      print('null picked');
    }
    else{
      setState(() {
        _selectedDate=_pickedDate;
      });
      print('date=$_selectedDate');
    }
   }
   
   
   
   

   _getStartTimeFromUser()async{
   TimeOfDay? pickedStartTime= await showTimePicker(
     initialEntryMode:TimePickerEntryMode.input ,
        context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),

    );
   setState(() {
     _startTime=pickedStartTime!.format(context);
   });
   }
   _getEndTimeFromUser()async{
   TimeOfDay? pickedEndTime= await showTimePicker(
     initialEntryMode:TimePickerEntryMode.input ,
        context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15))),

    );
   setState(() {
     _endTime=pickedEndTime!.format(context);
   });
   }
}
