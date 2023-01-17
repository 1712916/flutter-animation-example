import 'package:flutter/material.dart';

class TikTokSpinner extends StatefulWidget {
  const TikTokSpinner({Key? key}) : super(key: key);

  @override
  _TikTokSpinnerState createState() => _TikTokSpinnerState();
}

class _TikTokSpinnerState extends State<TikTokSpinner> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    sizeAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(controller);
    scaleAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _getLeft() {
      if (sizeAnimation.value <= 1) {
        return sizeAnimation.value;
      }
      return 2 - sizeAnimation.value;
    }

    double _getScale() {
      if (scaleAnimation.value <= 1) {
        return scaleAnimation.value / 2 + 0.5;
      } else if (scaleAnimation.value <= 2) {
        return (2 - scaleAnimation.value) / 2 + 0.5;
      }
       else if (scaleAnimation.value <= 3) {
        return ( scaleAnimation.value - 3) / 4 + 0.25;
      }

      return (4 - scaleAnimation.value) / 4 + 0.25;
    }




    return ColoredBox(
      color: Colors.grey,
      child: SizedBox(
        height: 50,
        width: 100,
        child: Stack(
          children: [
            Positioned(
              left: _getLeft() * 50,
              child: Transform.scale(
                scale: _getScale(),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            // AnimatedBuilder(
            //   builder: (context, child) {
            //     // double _getLeft() {
            //     //   if (sizeAnimation.value <= 1.0) {
            //     //     return sizeAnimation.value;
            //     //   } else {
            //     //     return 2 - sizeAnimation.value;
            //     //   }
            //     // };
            //     return Positioned(
            //       left: sizeAnimation.value,
            //       child: child!,
            //     );
            //   },
            //   animation: controller,
            //   child: Container(
            //     width: 50,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.pink,
            //
            //     ),
            //   ),
            // ),
            // Positioned(
            //   right: 0,
            //   child: Container(
            //     width: 50,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.cyan,
            //
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TikTokSpinnerExample extends StatelessWidget {
  const TikTokSpinnerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TikTokSpinner(),
      ),
    );
  }
}
