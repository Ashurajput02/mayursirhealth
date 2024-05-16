import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncChart extends StatefulWidget {
  const SyncChart({Key? key, required this.data}) : super(key: key);
  final List<double> data;
  @override
  State<SyncChart> createState() => _SyncChartState();
}

class _SyncChartState extends State<SyncChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true, // Enable panning
          enablePinching: true, // Enable zooming
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.xy,
        ),
        series: <LineSeries>[
          LineSeries<double, int>(
            dataSource: widget.data,
            xValueMapper: (index, value) => value,
            yValueMapper: (index, value) => index,
            name: 'Data 1',
            color: Colors.red,
          ),
        ],
        primaryXAxis:
            const NumericAxis(isVisible: false), // Remove default X-axis
      ),
    );
  }
}
