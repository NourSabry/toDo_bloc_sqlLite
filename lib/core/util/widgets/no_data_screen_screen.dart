import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_algoriza/core/util/style/colors.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: Text(
              'You do not have any Tasks Yet ..!',
              style: TextStyle(color: defultColor, fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BounceInDown(
                    duration: Duration(seconds: 3),
                    child: SizedBox(
                        height: size.height / 5,
                        width: size.width - 45,
                        child: SvgPicture.asset("assets/images/toDo.svg"))),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Square() => Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: defultColor,
      ),
    );
