import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class CameraButton extends StatefulWidget {
  double goalCompleted = 0.99;
  CameraButton({Key key}) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _progressAnimation;
  double progressdegree = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _progressAnimation =
        Tween(begin: 0.0, end: 360.0).animate(_animationController)
          ..addListener(() {
            setState(() {
              progressdegree = widget.goalCompleted * _progressAnimation.value;
            });
          });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(
            height: 45,
            width: 45,
            child: InkWell(
              onTap: () {
                _animationController.forward();
              },
              onDoubleTap: () {
                _animationController.stop();
              },
            )),
        painter: ButtonPaint(progressdegree),
      ),
    );
  }
}

class ButtonPaint extends CustomPainter {
  double progressInDegree;
  ButtonPaint(this.progressInDegree);

  @override
  void paint(Canvas canvas, Size size) {
    Paint inerpaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;
    Offset innercentre = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(innercentre, size.width / 2.7, inerpaint);
    Paint paint = Paint()
      ..color = Colors.white12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Offset centre = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centre, size.width / 2, paint);

    Paint progresspaint = Paint()
      ..color = Color(0xFF1ED761)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawArc(
        Rect.fromCircle(center: centre, radius: size.width / 1.7),
        math.radians(-90),
        math.radians(progressInDegree),
        false,
        progresspaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
