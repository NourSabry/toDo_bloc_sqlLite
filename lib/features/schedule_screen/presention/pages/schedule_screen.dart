import 'package:flutter/material.dart';
import 'package:todo_algoriza/features/schedule_screen/presention/widgets/schedule_widget.dart';
 import '../../../../core/util/widgets/custom_Icon_Button.dart';
import '../../../../core/util/constant/constant.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        leading: CustomIconButton(
          onTap: () {
            NavigatePop(context: context);
          },
          Widgeticon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: ScheduleWidget(),
    );
  }
}
