import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_1/src/apis/api.dart';
import 'package:mini_project_1/src/features/authentication/screens/homescreen/homescreen.dart';
import 'package:mini_project_1/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';

//global object for accessing device screen size
late Size mq;

// statefull widget as we are dynamically changing it
class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      //exit fullscreen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors
              .white)); //need it to be transparent in both light&dark themes
      if (APIs.auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const homeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const onBoardingScreen()));
      }
    }); // after one and half a second
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: mq.height * .3, // 30 % from top of screen
      //       width: mq.width *
      //           .80, // 80 % of the screen leaves 10 % on each side for space look left mq
      //       right: mq.width * .10, // 10% from left
      //       child: Image.asset(
      //         'assets/icons/app_title.png',
      //         color: Colors.black,
      //         height: 250,
      //       ),
    );
    // Positioned(
    //   bottom: mq.height * .2,
    //   left: mq.width * .4,
    //   child: Image.asset(
    //     "assets/images/loading.gif",
    //     height: 50,
    //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
