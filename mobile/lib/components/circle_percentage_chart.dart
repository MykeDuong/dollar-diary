import 'dart:math';
import 'dart:ui';

import 'package:vector_graphics/vector_graphics_compat.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:dollar_diary/constants/colors.dart';
import 'package:dollar_diary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CirclePercentageChartObservation {
  final double value;
  final String label;
  late PictureInfo asset;

  CirclePercentageChartObservation._create({
    required this.value,
    required this.label,
  });

  static Future<CirclePercentageChartObservation> create({
    required double value,
    required String label,
    required String assetName,
  }) async {
    var component = CirclePercentageChartObservation._create(
      value: value,
      label: label,
    );

    component.asset = await vg.loadPicture(
      SvgAssetLoader(assetName),
      null,
      clipViewbox: true,
      onError: (Object o, StackTrace? s) {
        print(s);
      },
    );
    return component;
  }
}

class CirclePercentageChart extends ConsumerStatefulWidget {
  late List<Future<CirclePercentageChartObservation>> observations;

  CirclePercentageChart({
    Key? key,
    required this.observations,
  }) : super(key: key);

  @override
  ConsumerState<CirclePercentageChart> createState() =>
      _CirclePercentageChartConsumerState();
}

class _CirclePercentageChartConsumerState
    extends ConsumerState<CirclePercentageChart> {
  double total = 0;
  late List<CirclePercentageChartObservation> observations;

  void _getObservations() async {
    observations = [];
    var finishedObservations = await Future.wait(widget.observations);
    setState(() {
      observations = finishedObservations;
    });
    double totalValue = 0;
    observations.forEach((o) {
      totalValue += o.value;
    });
    setState(() {
      total = totalValue;
    });
  }

  @override
  void initState() {
    _getObservations();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final highlightColor = ref.watch(chosenHighlightColorProvider);
    return CustomPaint(
      painter: ChartPainter(
        observations: observations,
        total: total,
        unusedHighlightColor: highlightColor,
      ),
      child: Container(),
    );
    // return Container(child: observations[0].asset.picture.toImageSync(20, 20))
  }
}

class ChartPainter extends CustomPainter {
  static const kCircularAngle = 2 * pi;
  late double radius;
  late Offset center;
  double currentDeg = -pi / 2;
  late Rect boundingRect;
  final double total;
  final Color unusedHighlightColor;
  final List<CirclePercentageChartObservation> observations;

  ChartPainter({
    required this.observations,
    required this.total,
    required this.unusedHighlightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colors = kHighlightColors
        .where((element) => element != unusedHighlightColor)
        .toList();
    radius = min(size.width, size.height) / 2 - 2;
    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    center = Offset(
      size.width / 2,
      size.height / 2,
    );

    boundingRect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );

    for (int i = 0; i < observations.length; i++) {
      drawObservation(canvas, observations[i], colors[i]);
    }
  }

  void drawObservations(
    Canvas canvas,
    List<CirclePercentageChartObservation> observations,
    List<Color> colors,
  ) async {
    for (int i = 0; i < observations.length; i++) {
      drawObservation(canvas, observations[i], colors[i]);
    }
  }

  void drawObservation(
    Canvas canvas,
    CirclePercentageChartObservation observation,
    Color color,
  ) {
    final ratio = observation.value / total;
    canvas.drawArc(
      boundingRect,
      currentDeg,
      ratio * kCircularAngle,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0,
    );
    final middlePoint = _angleToPoint(currentDeg + ratio * kCircularAngle / 2);
    Rect bgRect = Rect.fromCenter(
      center: middlePoint,
      width: 30.0,
      height: 30.0,
    );
    canvas.drawRect(
        Rect.fromCenter(
          center: middlePoint,
          width: 32.0,
          height: 32.0,
        ),
        Paint()..color = kMutedSurfaceColor);
    // final image = await observation.asset.picture.toImage(100, 100);
    paintImage(
      canvas: canvas,
      rect: bgRect,
      image: observation.asset.picture.toImageSync(30, 30),
      // image: image,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      isAntiAlias: true,
      filterQuality: FilterQuality.high,
    );

    currentDeg += ratio * kCircularAngle;
  }

  Offset _angleToPoint(double angle) {
    return Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
