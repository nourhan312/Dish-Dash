import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../Controler/auth_repo.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController emailController = TextEditingController();
  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Scaffold(
          backgroundColor: Color(0xffC3211A),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 500),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        Text(
                          'to reset your password\n\nplease enter your email address\nand click on the button below',
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 45),
                        TextFormField(
                          focusNode: focusNode,
                          autocorrect: true,
                          textDirection: TextDirection.ltr,
                          cursorWidth: 0.6,
                          smartQuotesType: SmartQuotesType.enabled,
                          smartDashesType: SmartDashesType.enabled,
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: Colors.black,
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else if (!value.trim().isValidEmailAddress()) {
                              return 'invalid email';
                            } else if (value.trim().isValidEmailAddress()) {
                              return null;
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).canvasColor,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Dosis',
                              letterSpacing: 2,
                              fontStyle: FontStyle.italic,
                            ),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                            hintText: 'enter your email',
                            hintStyle: TextStyle(
                              fontFamily: 'Dosis',
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              focusNode.unfocus();
                              if (formKey.currentState!.validate()) {
                                AuthRepo.sendPasswordResetEmail(
                                  emailController.text.trim(),
                                  context,
                                );
                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    Flushbar(
                                      message: "Check your Inbox",
                                      icon: Icon(
                                        Icons.check_circle,
                                        size: 28.0,
                                        color: Colors.green,
                                      ),
                                      duration: Duration(seconds: 3),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    ).show(context);
                                  },
                                );
                                Future.delayed(
                                  const Duration(milliseconds: 2400),
                                  () {
                                    Get.back();
                                  },
                                );
                              } else {
                                Flushbar(
                                  message: "please fill all fields",
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
                            child: Center(
                              child: Text(
                                'Send Reset Password Link',
                                style: TextStyle(
                                  fontFamily: 'Dosis',
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            "Return to Login",
                            style: TextStyle(
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
      ),
    );
  }
}

extension EnailValidator on String {
  bool isValidEmailAddress() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
