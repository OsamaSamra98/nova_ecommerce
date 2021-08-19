import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nova_ecommerce/getx/user_getx_controller.dart';
import 'package:nova_ecommerce/utils/AppColors.dart';
import 'package:nova_ecommerce/utils/app_text.dart';
import 'package:nova_ecommerce/utils/app_textfield.dart';
import 'package:nova_ecommerce/utils/code_text_field.dart';
import 'package:nova_ecommerce/utils/helper.dart';

import 'login_Screen.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String phone;

  ResetPasswordScreen({required this.phone});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _code = '';
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode fourthFocusNode;

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_COLOR,

      appBar: AppBar(
        centerTitle: true,
        title: AppText(
          text: 'Reset Password',
          color: AppColors.Orange_COLOR,
          fontsize: 20,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(25),
        shrinkWrap: true,
        children: [
          SizedBox(height: 70),
          AppText(
            text:
                'Enter 4 digit code verification, sent to your phone',
            color: Colors.grey,
            fontsize: 15,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CodeTextField(
                  textController: _firstCodeTextController,
                  focusNode: firstFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) secondFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15),
                CodeTextField(
                  textController: _secondCodeTextController,
                  focusNode: secondFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty)
                      firstFocusNode.requestFocus();
                    else
                      thirdFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15),
                CodeTextField(
                  textController: _thirdCodeTextController,
                  focusNode: thirdFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty)
                      secondFocusNode.requestFocus();
                    else
                      fourthFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15),
                CodeTextField(
                  textController: _fourthCodeTextController,
                  focusNode: fourthFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty) thirdFocusNode.requestFocus();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          app_textfield(
            controller: _newPasswordEditingController,
            title: 'Password',
            secure: true,
          ),
          app_textfield(
            controller: _newPasswordConfirmationEditingController,
            title: 'Confirm Password',
            secure: true,
          ),
          SizedBox(height: 150),
      Padding(
        padding: const EdgeInsets.only(right: 25),
        child: ElevatedButton(
          onPressed: ()async {
            await performResetPassword();
          },
          child: AppText(
            text: 'Confirm',
            color: Colors.white,
            fontsize: 16,
            fontWeight: FontWeight.bold,
          ),
          style: ElevatedButton.styleFrom(
              primary: AppColors.Orange_COLOR,
              minimumSize: Size(double.infinity, 64),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
        ),
      ),
        ],
      ),
    );
  }

  Future performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (isValidCode() && isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context,
          text: 'Password is not confirmed correctly!', error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty;
  }

  bool isValidCode() => code.isNotEmpty && _code.length == 4;

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  String get code {
    return _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }

  Future resetPassword() async {
    bool status = await UsersGetxController.to.resetPassword(
      context: context,
      mobile: widget.phone,
      password: _newPasswordEditingController.text,
      code: code,
    );
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.to(login_Screen());
  }
}
