// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_algoriza/features/boardScreen/presention/widget/board_widget.dart';
import 'package:todo_algoriza/features/schedule_screen/presention/pages/schedule_screen.dart';
import 'package:todo_algoriza/core/util/Bloc/cubit.dart';
import 'package:todo_algoriza/core/util/Bloc/states.dart';
import 'package:todo_algoriza/core/util/style/colors.dart';
import '../../../../core/util/widgets/custom_Icon_Button.dart';
import '../../../../core/util/constant/constant.dart';

class Boardscreen extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.white,
          fontSize: 18,
        );
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppBloc cubit = AppBloc.get(context);
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            key: ScaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120), // Set this height
              child: Container(
                decoration: BoxDecoration(
                  color: defultColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                padding: EdgeInsets.only(top: 15),
                child: AppBar(
                  backgroundColor: secondColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  title: Text(
                    'Your Tasks',
                    style: TextStyle(
                      fontSize: 25,
                      color: defultColor,
                    ),
                  ),
                  actions: [
                    CustomIconButton(
                      onTap: () {
                        NavigateTo(context: context, router: ScheduleScreen());
                      },
                      Widgeticon: Icon(
                        Icons.date_range,
                        color: defultColor,
                      ),
                    ),
                    CustomIconButton(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Delete All Items',
                            style: textTheme,
                          ),
                          content: Text(
                            'Do You sure ?',
                            style: textTheme,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: textTheme,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                AppBloc.get(context)
                                    .deleteAll(Database: cubit.db);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: textTheme,
                              ),
                            ),
                          ],
                          elevation: 24,
                          backgroundColor: defultColor,
                          // shape: CircleBorder(),
                        ),
                      ),
                      Widgeticon: Icon(
                        Icons.cleaning_services,
                        color: defultColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: BoarderWidget(),
          ),
        );
      },
    );
  }
}
