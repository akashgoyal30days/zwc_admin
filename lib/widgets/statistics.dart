import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/dashboard_controller.dart';

class Statistics extends StatefulWidget {
  const Statistics(
      {super.key, required this.dateRange, required this.wastecollected});
  final DateTimeRange dateRange;
  final String wastecollected;
  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
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
                      "Statistics",
                      style: GoogleFonts.montserrat(
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
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Dry Waste",
                          style: GoogleFonts.montserrat(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 15,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Wet Waste",
                          style: GoogleFonts.montserrat(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // viewGraphIndex = 0;
                      // setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          viewGraphIndex == 0 ? Colors.green : Colors.white),
                      foregroundColor: MaterialStateProperty.all(
                          viewGraphIndex == 0 ? Colors.white : Colors.green),
                    ),
                    child: FittedBox(
                        child: Text(widget.wastecollected.toString() == "null"
                            ? "Waste Collected"
                            : "${widget.wastecollected.toString()}")),
                  ),
                ),
                const SizedBox(width: 6),
                // Expanded(
                //   child: OutlinedButton(
                //     onPressed: () {
                //       viewGraphIndex = 1;
                //       setState(() {});
                //     },
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(
                //           viewGraphIndex == 1 ? Colors.green : Colors.white),
                //       foregroundColor: MaterialStateProperty.all(
                //           viewGraphIndex == 1 ? Colors.white : Colors.green),
                //     ),
                //     child: const FittedBox(
                //       child: Text(
                //         "Dry waste Collection",
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: viewGraphIndex == 0,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  isVisible: true
                ),
                series: [
                  ColumnSeries<drywetWasteCollectedModel, String>(
                    color: Colors.yellow,
                    dataSource: controller.drywetwastecollection,
                    xValueMapper: (drywetWasteCollectedModel sales, _) =>
                        sales.label.toString(),
                    yValueMapper: (drywetWasteCollectedModel sales, _) =>
                        sales.data,
                  ),
                  ColumnSeries<drywetWasteCollectedModel, String>(
                    color: Colors.orange,
                    dataSource: controller.drywetwastecollection,
                    xValueMapper: (drywetWasteCollectedModel sales, _) =>
                        sales.label.toString(),
                    yValueMapper: (drywetWasteCollectedModel sales, _) =>
                        sales.data2,
                  )
                ],
              ),
            ),
          ]),
        ),
      );
    });
  }
}
