import 'package:covid19tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: Duration(milliseconds:1000),
    vsync: this,
  )..repeat();// Starts the animation
late final Animation<double> _ScaleAnimation = Tween<double>(begin: 1,end : 1.2).animate(CurvedAnimation(parent: controller, curve: Curves.elasticInOut));
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WorldStates(controller : controller)));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image.asset('images/virus.png'),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return ScaleTransition(
                  scale: _ScaleAnimation,
                  child: Transform.rotate(
                    angle: controller.value * 2 * math.pi/10, // Full circle rotation
                    child: child,
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Covid-19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
