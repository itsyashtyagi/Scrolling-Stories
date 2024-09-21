import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrolling_stories/constant/string_constant.dart';
import 'package:scrolling_stories/provider/stories_provider.dart';
import 'package:scrolling_stories/repository/stories_repository.dart';
import 'package:scrolling_stories/ui/initial_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, index) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => StoriesProvider(
              StoriesRepository(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) {
            return const MaterialApp(
              title: StringConstant.kAppTitle,
              debugShowCheckedModeBanner: false,
              home: InitialScreen(),
            );
          },
        ),
      ),
    );
  }
}
