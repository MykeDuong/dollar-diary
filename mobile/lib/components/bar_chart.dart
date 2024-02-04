import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:dollar_diary/util.dart';

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

class _BarChartConsumerState extends ConsumerState<BarChart>
    with SingleTickerProviderStateMixin {
  late double _upperBound;
  late List<double> _Y;
  late List<String> _X;
  int _chosenIndex = -1;
  late Animation<double> _animation;
  late AnimationController controller;
  double growthRatio = 0;

  void _createUpperBound(double max) {
    int numOfDigits = log10(max).floor();
    double firstDigits = max * 1.2 / pow(10, ((numOfDigits / 3).floor() * 3));
    firstDigits = double.parse(firstDigits.toStringAsFixed(1)) * 10;
    num newMax = (firstDigits + (3 - firstDigits % 3)) *
        pow(10, ((numOfDigits / 3).floor() * 3) - 1);
    setState(() {
      _upperBound = newMax.toDouble();
    });
  }

  setChosenIndex(int index) {
    if (index == -1 || index == _chosenIndex) return;
    setState(() {
      _chosenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    controller.forward();

    var max = -double.maxFinite;
    widget.observations.forEach((o) {
      max = max < o.value ? o.value : max;
      _Y = widget.observations.map((o) => o.value).toList();
      _X = widget.observations.map((o) => o.period).toList();
    });
    _createUpperBound(max);
  }

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          growthRatio = _animation.value;
        });
      });

    return GestureDetector(
      child: CustomPaint(
        painter: ChartPainter(
          x: _X,
          y: _Y,
          max: _upperBound,
          chosen: _chosenIndex,
          onTapCallback: setChosenIndex,
          highlightColor: highlightColor,
          growthRatio: growthRatio,
        ),
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ChartPainter extends CustomPainter {
  static const double border = 5.0;
  static const double yTextWidth = 40.0;

  final List<String> x;
  final List<double> y;
  final double max;
  final Color highlightColor;
  int chosen;
  final Function(int index) onTapCallback;
  final growthRatio;

  List<Rect> bars = [];

  ChartPainter({
    required this.x,
    required this.y,
    required this.max,
    this.chosen = -1,
    required this.onTapCallback,
    required this.highlightColor,
    this.growthRatio = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final drawableHeight = size.height - border * 2.0;
    final drawableWidth = size.width - border * 2.0;
    final wd = (drawableWidth - yTextWidth) / x.length.toDouble();
    final height = drawableHeight * 0.9;
    final width = drawableWidth;
    if (height <= 0 || width <= 0) return;

    final hr = height / max;

    /* MARK: DRAWING SECTION */
    //_drawAxis(canvas, height, width, yTextWidth);
    _drawTextYAxis(canvas, height, hr, max);

    var c = Offset(
      border + yTextWidth + wd / 2.0,
      border + height / 2.0,
    );

    y.asMap().forEach((index, value) {
      _drawBars(canvas, c, index, value, wd, height, hr);
      _drawValue(canvas, c, index, value, hr * value, wd);
      _drawTextXAxis(canvas, c, index, x[index], hr * value, wd);
      //_drawOutline(canvas, c, wd, height);
      c += Offset(wd, 0);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawOutline(Canvas canvas, Offset c, double width, double height) {
    final rect = Rect.fromCenter(center: c, width: width, height: height);
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawBars(Canvas canvas, Offset c, int index, double value, double width,
      double height, double hr) {
    final dp = Offset(
      c.dx,
      c.dy + (height) / 2.0 - value * hr / 2,
    );
    Rect cornerBar = Rect.fromCenter(
      center: dp,
      width: width - 20.0,
      height: value * hr * growthRatio,
    );
    bars.add(cornerBar);
    RRect bar = RRect.fromRectAndRadius(cornerBar, const Radius.circular(8.0));
    canvas.drawRRect(
      bar,
      Paint()..color = index == chosen ? highlightColor : kOverlaySurfaceColor,
    );
  }

  int getTappedBar(Offset offset) {
    for (int i = 0; i < bars.length; i++) {
      if (bars[i].contains(offset)) return i;
    }
    return -1;
  }

  @override
  bool? hitTest(Offset position) {
    int index = getTappedBar(position);
    if (index == chosen || index == -1) {
      return false;
    } else {
      onTapCallback(index);
      return true;
    }
  }

  TextPainter measureText(
      String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s, style: style);
    final tp = TextPainter(
      text: span,
      textAlign: align,
      textDirection: TextDirection.ltr,
    );
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  void _drawValue(Canvas canvas, Offset c, int index, double value,
      double height, double maxWidth) {
    TextStyle style = TextStyle(
      color: index == chosen ? highlightColor : kClearColor,
      fontSize: 10,
    );
    final tp =
        measureText(numberFormat(value, 2), style, maxWidth, TextAlign.center);
    final offset = Offset(
      c.dx - tp.width / 2.0,
      c.dy * 2 - tp.height * 2 - height - 5.0,
    );
    tp.paint(canvas, offset);
  }

  void _drawTextXAxis(Canvas canvas, Offset c, int index, String label,
      double height, double maxWidth) {
    TextStyle style = TextStyle(
      color: index == chosen ? highlightColor : kMutedGreyColor,
      fontSize: 16,
    );
    final tp = measureText(label, style, maxWidth, TextAlign.center);
    final offset = Offset(
      c.dx - tp.width / 2.0,
      c.dy * 2,
    );
    tp.paint(canvas, offset);
  }

  void _drawTextYAxis(Canvas canvas, double height, double hr, double max) {
    TextStyle style = const TextStyle(color: kMutedGreyColor, fontSize: 16);
    for (int i = 0; i < 4; i++) {
      double heightValue = height / 3 * i;
      double value = heightValue / hr;
      var str = numberFormat(value, 0);
      final tp = measureText(str, style, yTextWidth, TextAlign.center);
      final offset = Offset(
        border + yTextWidth - tp.width,
        height - heightValue - 3,
      );
      tp.paint(canvas, offset);
    }
  }

  void _drawAxis(
      Canvas canvas, double height, double width, double yTextWidth) {
    Rect yAxis = Rect.fromLTWH(yTextWidth + border, border, 0, height);
    canvas.drawRect(
      yAxis,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );

    Rect xAxis = Rect.fromLTWH(yTextWidth + border, height + border, width, 0);
    canvas.drawRect(
      xAxis,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );
  }
}
