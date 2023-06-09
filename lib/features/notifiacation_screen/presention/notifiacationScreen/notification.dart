import 'package:flutter/material.dart';
 import '../../../../core/util/widgets/custom_Icon_Button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add task'),
          leading: CustomIconButton(
            onTap: () {
             },
            Widgeticon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          )),
      body: Center(
        child: Text(
          this.payload.toString().split('|')[0],
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
