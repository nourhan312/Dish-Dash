import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../Controler/auth_repo.dart';
import '../../LogicCode/common_functions.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  bool checkOldPasswordValidation = true;
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: GestureDetector(
        onTap: () {
          focusNode1.unfocus();
          focusNode2.unfocus();
          focusNode3.unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text('Change Password'),
            leading: const BackButton(),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 300),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'to change password please fill in the\nform below and click save changes',
                        style: TextStyle(
                          fontFamily: 'Dosis',
                          fontSize: 18,
                          letterSpacing: 1,
                          color: Theme.of(context).secondaryHeaderColor,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          focusNode: focusNode1,
                          cursorWidth: 0.6,
                          cursorColor: Theme.of(context).primaryColor,
                          smartQuotesType: SmartQuotesType.enabled,
                          smartDashesType: SmartDashesType.enabled,
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1,
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'enter your old password';
                            }
                            return null;
                          },
                          controller: oldPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Old Password',
                            errorText: checkOldPasswordValidation != true
                                ? 'not valid old password'
                                : null,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Dosis',
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            hintText: 'enter your current password',
                            hintStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(
                              Icons.password_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          focusNode: focusNode2,
                          cursorWidth: 0.6,
                          cursorColor: Theme.of(context).primaryColor,
                          smartQuotesType: SmartQuotesType.enabled,
                          smartDashesType: SmartDashesType.enabled,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1,
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'enter new password';
                            }
                            return null;
                          },
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Dosis',
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            hintText: 'enter your new password',
                            hintStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(
                              Icons.password_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          focusNode: focusNode3,
                          cursorWidth: 0.6,
                          cursorColor: Theme.of(context).primaryColor,
                          smartQuotesType: SmartQuotesType.enabled,
                          smartDashesType: SmartDashesType.enabled,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1,
                          ),
                          validator: (value) {
                            if (value!.trim() !=
                                newPasswordController.text.trim()) {
                              return 'Password not matching';
                            } else if (value.trim().isEmpty) {
                              return 're-enter your new password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Repeat password',
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Dosis',
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            hintText: 're-enter your new password',
                            hintStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Theme.of(context).secondaryHeaderColor,
                              letterSpacing: 2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: Icon(
                              Icons.password_outlined,
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FlutterPwValidator(
                          defaultColor: Theme.of(context).secondaryHeaderColor,
                          controller: newPasswordController,
                          minLength: 8,
                          uppercaseCharCount: 1,
                          numericCharCount: 2,
                          specialCharCount: 1,
                          width: 350,
                          height: 140,
                          onSuccess: () {},
                          onFail: () {},
                        ),
                      ),
                      SizedBox(height: 60),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () async {
                            focusNode1.unfocus();
                            focusNode2.unfocus();
                            focusNode3.unfocus();
                            if (formKey.currentState!.validate()) {
                              checkOldPasswordValidation =
                                  await AuthRepo.checkOldPassword(
                                FirebaseAuth.instance.currentUser!.email,
                                oldPasswordController.text.trim(),
                              );
                              setState(() {});
                              checkOldPasswordValidation == true
                                  ? await AuthRepo.updateUserPassword(
                                      newPasswordController.text.trim(),
                                    ).whenComplete(() async {
                                      // showLoadingDialog(context);
                                      await FirebaseFirestore.instance
                                          .runTransaction(
                                        (transaction) async {
                                          DocumentReference documentReference =
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                  );
                                          transaction.update(
                                            documentReference,
                                            {
                                              'password': newPasswordController
                                                  .text
                                                  .trim(),
                                            },
                                          );
                                        },
                                      );
                                      formKey.currentState!.reset();
                                      newPasswordController.clear();
                                      oldPasswordController.clear();
                                      Flushbar(
                                        message:
                                            "your password has been updated",
                                        icon: Icon(
                                          Icons.check_circle,
                                          size: 28.0,
                                          color: Colors.green,
                                        ),
                                        duration: Duration(seconds: 3),
                                        leftBarIndicatorColor: Colors.blue[300],
                                      ).show(context);
                                      Future.delayed(
                                        const Duration(
                                          milliseconds: 1500,
                                        ),
                                      ).whenComplete(
                                        () => Get.back(),
                                      );
                                    })
                                  : null;
                            } else {
                              Flushbar(
                                message: "there is an error",
                                icon: Icon(
                                  Icons.error_outline,
                                  size: 28.0,
                                  color: Colors.red,
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.blue[300],
                              ).show(context);
                            }
                          },
                          child: Text("Save Changes"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
