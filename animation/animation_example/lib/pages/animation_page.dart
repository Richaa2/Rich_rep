import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationWidget(),
      ),
    );
  }
}

class AnimationWidget extends StatefulWidget {
  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> rotation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 2 * Math.pi).animate(controller)
        as Animation<double>;

    controller.addListener(() {
      print('Status: ${controller.status}');
      // if (controller.status == AnimationStatus.completed) {
      //   controller.reverse();
      // } else if (controller.status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controller.forward();
    controller.repeat();
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        print(rotation.value);
        return Transform.rotate(
            angle: rotation.value, child: const _MyContainer());
      },
    );
  }
}

class _MyContainer extends StatelessWidget {
  const _MyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: Colors.orange),
    );
  }
}
