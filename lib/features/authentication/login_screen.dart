// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_algoriza/core/util/Bloc/cubit.dart';
import 'package:todo_algoriza/core/util/Bloc/states.dart';
import 'package:todo_algoriza/core/util/style/colors.dart';
import 'package:todo_algoriza/core/util/widgets/custom_Button.dart';
import 'package:todo_algoriza/core/util/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  var FormKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AppBloc, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppBloc cubit = AppBloc.get(context);
          return Form(
            key: FormKey,
            child: Padding(
              padding: EdgeInsets.only(top: size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    FieldName: "Email Address",
                    controller: cubit.emailAdressController,
                    hintText: "Enter your mail here",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CustomTextField(
                    FieldName: "Password",
                    controller: cubit.passwordController,
                    hintText: "Enter your password here",
                    textInputType: TextInputType.visiblePassword,
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Login',
                    onTap: () {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'You don not have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'Register',
                              style: TextStyle(color: defultColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
