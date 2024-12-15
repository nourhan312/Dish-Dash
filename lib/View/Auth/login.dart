import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:dish_dash/View/on_boarding/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../Controler/auth_repo.dart';
import '../../Controler/id_provider.dart';
import 'forgot_password.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await users.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  setUserId(User user) {
    context.read<IdProvider>().setCustomerId(user);
  }

  bool docExists = false;
  late String email;
  late String password;
  bool processing = false;
  bool sendEmailVerification = false;
  final spinkit = const SpinKitFadingCube(
    color: Colors.black,
    size: 25,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;

  void navigate() {
    Get.off(
      OnboardingScreen(),
      transition: Transition.fadeIn,
    );
  }

  void logIn() async {
    focusNode1.unfocus();
    focusNode2.unfocus();
    setState(() {
      processing = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (_formKey.currentState!.validate()) {
        try {
          await AuthRepo.signInWithEmailAndPassword(email, password);
          await AuthRepo.reloadUserData();
          if (await AuthRepo.checkEmailVerification()) {
            _formKey.currentState!.reset();
            User user = FirebaseAuth.instance.currentUser!;
            setUserId(user);
            navigate();
          } else {
            setState(() {
              processing = false;
              sendEmailVerification = true;
            });
            Flushbar(
              message: "please check your inbox",
              icon: Icon(
                Icons.error_outline,
                size: 28.0,
                color: Colors.red,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue[300],
            ).show(context);
          }
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });
          Flushbar(
            message: e.toString(),
            icon: Icon(
              Icons.error_outline,
              size: 28.0,
              color: Colors.red,
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.blue[300],
          ).show(context);
        }
      } else {
        setState(() {
          processing = false;
        });
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
    });
  }

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: GestureDetector(
        onTap: () {
          focusNode1.unfocus();
          focusNode2.unfocus();
        },
        child: Scaffold(
          backgroundColor: Color(0xff3E2823),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Log In",
                                style: TextStyle(
                                  fontFamily: 'Limelight',
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        sendEmailVerification == true
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      Flushbar(
                                        message:
                                            "Sending email verification . . .",
                                        icon: Icon(
                                          Icons.check_circle,
                                          size: 28.0,
                                          color: Colors.green,
                                        ),
                                        duration: Duration(seconds: 3),
                                        leftBarIndicatorColor: Colors.blue[300],
                                      ).show(context);
                                      try {
                                        await FirebaseAuth.instance.currentUser!
                                            .sendEmailVerification();
                                      } catch (e) {
                                        if (kDebugMode) {
                                          print(e);
                                        }
                                      }
                                      Future.delayed(
                                        const Duration(seconds: 3),
                                      ).whenComplete(() {
                                        setState(() {
                                          sendEmailVerification == false;
                                        });
                                        Flushbar(
                                          message: "Check your email now",
                                          icon: Icon(
                                            Icons.check_circle,
                                            size: 28.0,
                                            color: Colors.green,
                                          ),
                                          duration: Duration(seconds: 3),
                                          leftBarIndicatorColor:
                                              Colors.blue[300],
                                        ).show(context);
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Resend Email Verification',
                                        style: TextStyle(
                                          fontFamily: 'Dosis',
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            focusNode: focusNode1,
                            autocorrect: true,
                            cursorWidth: 0.6,
                            smartQuotesType: SmartQuotesType.enabled,
                            smartDashesType: SmartDashesType.enabled,
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email ';
                              } else if (value.isValidEmail() == false) {
                                return 'invalid email';
                              } else if (value.isValidEmail() == true) {
                                return null;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value.trim();
                            },
                            //  controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
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
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                fontFamily: 'Dosis',
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Dosis',
                                color: Colors.black,
                                letterSpacing: 1,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            focusNode: focusNode2,
                            cursorColor: Colors.black,
                            autocorrect: true,
                            cursorWidth: 0.6,
                            smartQuotesType: SmartQuotesType.enabled,
                            smartDashesType: SmartDashesType.enabled,
                            style: TextStyle(
                              fontFamily: 'Dosis',
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value.trim();
                            },
                            //   controller: _passwordController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).canvasColor,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontFamily: 'Dosis',
                                letterSpacing: 2,
                                fontStyle: FontStyle.italic,
                              ),
                              prefixIcon: Icon(
                                Icons.password,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                fontFamily: 'Dosis',
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Dosis',
                                color: Colors.black,
                                letterSpacing: 1,
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(
                                  const ForgotPassword(),
                                  transition: Transition.leftToRight,
                                );
                              },
                              child: Text(
                                'Forget Password ?',
                                style: TextStyle(
                                  fontFamily: 'Dosis',
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Don\'t Have Account? Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Get.to(
                                  const SignUp(),
                                  transition: Transition.rightToLeftWithFade,
                                );
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                processing == true ? null : logIn();
                              },
                              child: processing == true
                                  ? SpinKitFadingCube(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      size: 18,
                                    )
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontFamily: 'Dosis',
                                        letterSpacing: 1,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^[a-zA-Z0-9\_\.\-]+[a-zA-Z0-9]*[@][a-zA-Z0-9]{2,}[\.][a-zA-Z]{2,3}$')
        .hasMatch(this);
  }
}
