import 'package:flutter/material.dart';
import 'package:scrolling_stories/constant/string_constant.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            StringConstant.kWillBeReadySoon,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
