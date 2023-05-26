import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_algoriza/features/schedule_screen/presention/widgets/task_tile.dart';
import 'package:todo_algoriza/core/util/Bloc/states.dart';
import 'package:todo_algoriza/core/util/widgets/no_data_screen_screen.dart';
import '../../../../core/util/Bloc/cubit.dart';

class ShowTask extends StatelessWidget {
  const ShowTask({Key? key, index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppBloc cubit = AppBloc.get(context);
          // var Tasks = cubit.allTasks;

          return AppBloc.get(context).allTasks.isEmpty
              ? Expanded(
                  child: EmptyScreen(),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      AppBloc.get(context).GetDataFromDataBase(cubit.db);
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var Tasks = cubit.allTasks;
                        if (Tasks[index]['repreat'] == 'Daily' ||
                            Tasks[index]['dateline'] ==
                                (cubit.scheduleDate != null
                                    ? DateFormat.yMMMd()
                                        .format(cubit.scheduleDate!)
                                    : DateFormat.yMMMd()
                                        .format(cubit.selectedDateNow))) {
                          DateTime date = DateFormat.jm()
                              .parse(Tasks[index]['starttime'].toString());
                          var myTime = DateFormat('HH:mm').format(date);
                          cubit.notifyHelper.scheduledNotification(
                              int.parse(myTime.toString().split(':')[0]),
                              int.parse(myTime.toString().split(':')[1]),
                              Tasks);

                          return TaskTile(
                            item: AppBloc.get(context).allTasks[index],
                            color: cubit
                                .colorslist[index % cubit.colorslist.length],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                      itemCount: AppBloc.get(context).allTasks.length,
                    ),
                  ),
                );
        });
  }
}
