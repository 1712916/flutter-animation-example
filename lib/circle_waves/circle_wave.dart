import 'package:flutter/material.dart';

class CircleWaveExample extends StatelessWidget {
  const CircleWaveExample({Key? key}) : super(key: key);

  static const int delayedMillisecondsTime = 500;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Stack(
        fit: StackFit.expand,
        children: const [
          CircleWaveWidget(delayedTime: Duration()),
          CircleWaveWidget(delayedTime: Duration(milliseconds: delayedMillisecondsTime)),
          CircleWaveWidget(delayedTime: Duration(milliseconds: 2 * delayedMillisecondsTime)),
          CircleWaveWidget(delayedTime: Duration(milliseconds: 3 * delayedMillisecondsTime)),
        ],
      ),
    );
  }
}

class CircleWaveWidget extends StatefulWidget {
  const CircleWaveWidget({Key? key, required this.delayedTime}) : super(key: key);

  final Duration delayedTime;

  @override
  _CircleWaveWidgetState createState() => _CircleWaveWidgetState();
}

class _CircleWaveWidgetState extends State<CircleWaveWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    Future.delayed(widget.delayedTime).then((_) => controller.repeat());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleShapePainter(
        color: Colors.pinkAccent,
        radiusPercent: sizeAnimation.value,
      ),
    );
  }
}

class CircleShapePainter extends CustomPainter {
  final Color? color;
  final double radiusPercent;
  final PaintingStyle? paintingStyle;
  final StrokeCap? strokeCap;

  CircleShapePainter({
    this.color,
    this.radiusPercent = 10.0,
    this.paintingStyle,
    this.strokeCap,
  }) : assert(radiusPercent >= 0.0 && radiusPercent <= 1.0, 'radiusPercent = [0.0, 1.0]');

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.getMinSize() / 2;

    var paint = Paint()
      ..color = (color ?? Colors.black).withOpacity(1.0 - radiusPercent)
      ..strokeWidth = 1
      ..style = paintingStyle ?? PaintingStyle.fill
      ..strokeCap = strokeCap ?? StrokeCap.round;

    canvas.drawCircle(center, radius * radiusPercent, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

extension MinOfSize on Size {
  double getMinSize() {
    if (width > height) {
      return height;
    }
    return width;
  }
}
