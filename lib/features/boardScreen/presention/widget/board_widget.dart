import 'package:flutter/material.dart';
import 'package:todo_algoriza/core/util/style/colors.dart';
import 'package:todo_algoriza/features/createTaskScreen/presention/create_task_screen/create_task_screen.dart';
import 'package:todo_algoriza/features/boardScreen/presention/widget/favorite_widget.dart';
import 'package:todo_algoriza/core/util/widgets/custom_Button.dart';
import '../../../../core/util/constant/constant.dart';
import 'all_tasks_screen.dart';
import 'completed_screen.dart';
import 'un_completed_widget.dart';

class BoarderWidget extends StatelessWidget {
  const BoarderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          )),
          child: const TabBar(
            unselectedLabelColor: secondColor,
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: ' Un completed',
              ),
              Tab(
                text: 'Favorite',
              ),
            ],
          ),
        ),
        //Screens
        Expanded(
          child: TabBarView(
            children: [
              const AllScreen(),
              const CompletedScreen(),
              UnCompletedScreen(),
              const FavoriteScreen(),
            ],
          ),
        ),
        //Creat Task Button
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 25, left: 25),
          child: CustomButton(
              text: 'Create Task',
              onTap: () {
                NavigateTo(
                  context: context,
                  router: CreateTaskScreen(),
                );
              }),
        ),
      ],
    );
  }
}
