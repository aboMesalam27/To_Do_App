import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title!,
                      style: GoogleFonts.cairo(
                        color: colorWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey[400],
                          size: 18,
                        ),
                         SizedBox(
                          width: 12,
                        ),
                        Text('${task.startTime} - ${task.endTime}',
                          style: GoogleFonts.cairo(
                            color: Colors.grey[400],
                              fontSize: 13,
                              ),)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(task.note!,
                      style: GoogleFonts.cairo(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),)
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]?.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: GoogleFonts.cairo(
                    color: colorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: _getBGCLr(task.color)
        ),
      ),
    );
  }

  _getBGCLr(int? color) {
    switch(color){
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
