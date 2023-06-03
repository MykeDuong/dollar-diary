import 'package:dollar_diary/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Observation {
  final double value;
  final String period;
  Observation({required this.value, required this.period});
}

class BarChart extends ConsumerStatefulWidget {
  final List<Observation> observations;

  const BarChart({Key? key, required this.observations}) : super(key: key);

  @override
  ConsumerState<BarChart> createState() => _BarChartConsumerState();
}

class _BarChartConsumerState extends ConsumerState<BarChart> {
  late double _max;
  late List<double> _Y;
  late List<String> _X;

  @override
  void initState() {
    super.initState();
    var max = -double.maxFinite;
    widget.observations.forEach((o) {
      max = max < o.value ? o.value : max;
      _Y = widget.observations.map((o) => o.value).toList();
      _X = widget.observations.map((o) => o.period).toList();
    });
    setState(() {
      _max = max;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: ChartPainter(x: _X, y: _Y, max: _max),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  static double border = 10.0;

  final List<String> x;
  final List<double> y;
  final double max;

  ChartPainter({required this.x, required this.y, required this.max});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPaint(Paint()..color = const Color(0x00000000));
    final drawableHeight = size.height - border * 2.0;
    final drawableWidth = size.width - border * 2.0;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / x.length.toDouble();
    final height = hd * 3.0;
    final width = drawableWidth;
    if (height <= 0 || width <= 0) return;
    if (max < 1.0e-1) return;

    final hr = height / max;
    final left = border;
    final top = border;
    final c = Offset(left + wd / 2.0, top + height / 2.0);
    _drawOutline(canvas, c, wd, height);
    final points = _computePoints(c, wd, height, hr);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawOutline(Canvas canvas, Offset c, double width, double height) {
    y.forEach((value) {
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(
          rect,
          Paint()
            ..color = Colors.white
            ..strokeWidth = 1.0
            ..style = PaintingStyle.stroke);
      c += Offset(width, 0);
    });
  }

  List<Offset> _computePoints(
      Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    y.forEach((value) {
      final yy = height - value * hr;
      final dp = Offset(c.dx, c.dy - height / 2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    });
    return points;
  }
}
