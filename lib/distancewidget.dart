import 'package:flutter/material.dart';

class DistanceWidget extends StatefulWidget {
  DistanceWidget({Key key}) : super(key: key);

  @override
  _DistanceWidgetState createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: CustomPaint(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 65,
          width: 65,
          child: Column(
            children: <Widget>[
              Text("70"),
              Text("Km/hr"),
            ],
          ),
        ),
        painter: WidgetPaint(),
      ),
    );
  }
}

class WidgetPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint inerpaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;
    Offset innercentre = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(innercentre, size.width / 2.2, inerpaint);
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    Offset centre = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centre, size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
