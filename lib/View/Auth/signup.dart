import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import '../../Controler/auth_repo.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String name;
  late String email;
  late String password;
  late String profileImage;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;
  final spinkit = const SpinKitFadingCube(
    color: Colors.white70,
    size: 25,
  );

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void signUp() async {
    focusNode1.unfocus();
    focusNode2.unfocus();
    focusNode3.unfocus();
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await AuthRepo.signUpWithEmailAndPassword(email, password);
        AuthRepo.sendEmailVerification();
        _uid = AuthRepo.uid;
        AuthRepo.updateUserName(name);

        await users.doc(_uid).set({
          'uid': _uid,
          'name': name,
          'email': email,
          'password': password,
          'sign_up_date': DateFormat('d, M, yyyy').format(DateTime.now()),
        });
        _formKey.currentState!.reset();
        await Future.delayed(const Duration(microseconds: 100)).whenComplete(
          () => Get.offAll(
            const LoginScreen(),
            transition: Transition.fadeIn,
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          processing = false;
        });
        Flushbar(
          message: e.message.toString(),
          icon: Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.red,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue[300],
        ).show(context);
        if (e.code == 'weak-password') {
          setState(() {
            processing = false;
          });
          Flushbar(
            message: "The password provided is too weak",
            icon: Icon(
              Icons.error_outline,
              size: 28.0,
              color: Colors.red,
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.blue[300],
          ).show(context);
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            processing = false;
          });
          Flushbar(
            message: "The account already exists for that email",
            icon: Icon(
              Icons.error_outline,
              size: 28.0,
              color: Colors.red,
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.blue[300],
          ).show(context);
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      Flushbar(
        message: 'please fill all fields',
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      ).show(context);
    }
  }

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  @override
  Widget build(BuildContext context) {
    // const Color(0xff292C31),
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: GestureDetector(
        onTap: () {
          focusNode1.unfocus();
          focusNode2.unfocus();
          focusNode3.unfocus();
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
                                "Sign Up",
                                style: TextStyle(
                                  fontFamily: 'Limelight',
                                  color: Colors.white,
                                  fontSize: 40,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 58),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            focusNode: focusNode1,
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
                                return 'please enter your username';
                              }
                              if (value.length > 17) {
                                return 'username must be less than 17 character';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              name = value.trim();
                            },
                            maxLength: 17,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).canvasColor,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                letterSpacing: 2,
                                fontStyle: FontStyle.italic,
                              ),
                              labelText: 'Username',
                              hintText: 'enter your username',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1,
                              ),
                              prefixIcon: Icon(
                                FontAwesomeIcons.user,
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
                          padding: const EdgeInsets.all(10),
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
                              hintText: 'enter your email',
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
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            focusNode: focusNode3,
                            cursorColor: Colors.black,
                            autocorrect: true,
                            cursorWidth: 0.6,
                            smartQuotesType: SmartQuotesType.enabled,
                            smartDashesType: SmartDashesType.enabled,
                            style: TextStyle(
                              fontFamily: 'Dosis',
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your password';
                              }
                              if (value.contains("-")) {
                                return "can't include -";
                              }
                              if (value.length < 5) {
                                return 'weak password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value.trim();
                            },
                            //controller: _passwordController,
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
                              hintText: 'enter your password',
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
                                Icons.password,
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
                        TextButton(
                          child: Text(
                            'already have account? Log In',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Get.to(
                              const LoginScreen(),
                              transition: Transition.leftToRightWithFade,
                            );
                          },
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                processing == true ? null : signUp();
                              },
                              child: processing == true
                                  ? SpinKitFadingCube(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      size: 18,
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontFamily: 'Dosis',
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
