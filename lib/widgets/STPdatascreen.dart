import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/dashboard_controller.dart';

class StpDataScreen extends StatefulWidget {
  const StpDataScreen({
    super.key,
    required this.dateRange,
  });
  final DateTimeRange dateRange;
  @override
  State<StpDataScreen> createState() => _StatisticsState();
}

class _StatisticsState extends State<StpDataScreen> {
  int viewGraphIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Water Meter",
                      style: GoogleFonts.roboto(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                            children: [
                          TextSpan(
                              text: DateFormat("d MMMM")
                                  .format(widget.dateRange.start)),
                          const TextSpan(text: " - "),
                          TextSpan(
                              text: DateFormat("d MMMM")
                                  .format(widget.dateRange.end)),
                        ])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: viewGraphIndex == 0,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}\nltr',
                    title: AxisTitle(
                        text: "Liters (Ltr)",
                        textStyle: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    isVisible: true),
                series: [
                  ColumnSeries<WaterStpDataModel, String>(
                      color: Colors.green,
                      dataSource: controller.WatermeterData,
                      xValueMapper: (WaterStpDataModel sales, _) =>
                          sales.label.toString(),
                      yValueMapper: (WaterStpDataModel sales, _) =>
                          sales.data.toDouble(),
                      dataLabelSettings: DataLabelSettings(
                          builder:
                              (data, point, series, pointIndex, seriesIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                    "${controller.WatermeterData[pointIndex].data.toStringAsFixed(1)} ltr",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.green)),
                              ),
                            );
                          },
                          isVisible: true)),
                ],
              ),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Water Recycled",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Get.put(DashboardController())
                                  .TotalWaterRecylled!
                                  .toStringAsFixed(2)
                                  .toString() +
                              " Ltr",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Last Flow",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          Get.put(DashboardController())
                                  .WaterLastFlow!
                                  .toStringAsFixed(2)
                                  .toString() +
                              " Ltr",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
