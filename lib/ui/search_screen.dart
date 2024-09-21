import 'package:flutter/material.dart';
import 'package:scrolling_stories/constant/string_constant.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
