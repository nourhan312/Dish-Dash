import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Controler/auth_repo.dart';
import '../../../Controler/id_provider.dart';
import '../../Auth/login.dart';

class HeaderBox extends StatefulWidget {
  const HeaderBox({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderBox> createState() => _HeaderBoxState();
}

class _HeaderBoxState extends State<HeaderBox> {
  final userStream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  clearUserId() {
    context.read<IdProvider>().clearCustomerId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Banha, Egypt',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                StreamBuilder(
                    stream: userStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitWaveSpinner(
                              color: Theme.of(context).secondaryHeaderColor,
                              size: 20,
                            ),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            return Text(
                              "Hello ${snapshot.data['name']}",
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          }
                        default:
                          return const Center(
                            child: SpinKitWaveSpinner(
                              color: Colors.white70,
                              size: 20,
                            ),
                          );
                      }
                      return const Center(
                        child: SpinKitWaveSpinner(
                          color: Colors.white70,
                          size: 20,
                        ),
                      );
                    }),
              ],
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: (() async {
              await AuthRepo.logOut();
              clearUserId();
              await Future.delayed(
                const Duration(
                  microseconds: 50,
                ),
              ).whenComplete(
                () {
                  Get.offAll(
                    const LoginScreen(),
                  );
                },
              );
            }),
            child: Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(
                      image: AssetImage(
                        'assets/img.png',
                      ),
                      fit: BoxFit.cover),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 1,
                      color: Color.fromARGB(82, 0, 0, 0),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
