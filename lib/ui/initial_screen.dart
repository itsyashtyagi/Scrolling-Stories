import 'package:flutter/material.dart';
import 'package:scrolling_stories/constant/string_constant.dart';
import 'package:scrolling_stories/ui/home_screen.dart';
import 'package:scrolling_stories/ui/notification_screen.dart';
import 'package:scrolling_stories/ui/profile_screen.dart';
import 'package:scrolling_stories/ui/search_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _IntialScreenState();
}

class _IntialScreenState extends State<InitialScreen> {
  int selectedIndex = 0;

  final List<Widget> screenOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: selectedIndex,
                children: screenOptions,
              ),
            ),
            Positioned(
              bottom: height * 0.02,
              right: width * 0.10,
              left: width * 0.10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.10),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(
                          selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                        ),
                        label: StringConstant.kHome,
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(
                          selectedIndex == 1
                              ? Icons.search
                              : Icons.search_outlined,
                        ),
                        label: StringConstant.kSearch,
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(
                          selectedIndex == 2
                              ? Icons.notifications
                              : Icons.notifications_outlined,
                        ),
                        label: StringConstant.kNotification,
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.white,
                        icon: Icon(
                          selectedIndex == 3
                              ? Icons.person
                              : Icons.person_outline,
                        ),
                        label: StringConstant.kProfile,
                      ),
                    ],
                    currentIndex: selectedIndex,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.grey,
                    onTap: onItemTapped,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
