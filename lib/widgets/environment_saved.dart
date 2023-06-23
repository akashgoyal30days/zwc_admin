import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zwc/controllers/dashboard_controller.dart';

class EnvironmentSavedWidget extends StatefulWidget {
  const EnvironmentSavedWidget(
      {super.key, required this.environmentSaving, required this.dateRange});
  final List<CollectionModel> environmentSaving;
  final DateTimeRange dateRange;
  @override
  State<EnvironmentSavedWidget> createState() => _EnvironmentSavedWidgetState();
}

class _EnvironmentSavedWidgetState extends State<EnvironmentSavedWidget> {
  List<CollectionModel> currentSelection = [];
  TooltipBehavior? _tooltip;
  @override
  void initState() {
    currentSelection = widget.environmentSaving;
    _tooltip = TooltipBehavior(
      enable: true,
      shouldAlwaysShow: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Environmental Savings",
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
                      text:
                          DateFormat("d MMMM").format(widget.dateRange.start)),
                  const TextSpan(text: " - "),
                  TextSpan(
                      text: DateFormat("d MMMM").format(widget.dateRange.end)),
                ])),
            const SizedBox(height: 16),
            SfCircularChart(
                tooltipBehavior: _tooltip,
                legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                    shouldAlwaysShowScrollbar: true,
                    position: LegendPosition.top),
                series: [
                  DoughnutSeries<CollectionModel, String>(
                      radius: "75",
                      enableTooltip: true,
                      dataSource: currentSelection,
                      xValueMapper: (CollectionModel data, _) => data.label,
                      yValueMapper: (CollectionModel data, _) => data.data,
                      dataLabelSettings: DataLabelSettings(
                          builder:
                              (data, point, series, pointIndex, seriesIndex) {
                            return Text(
                                "${currentSelection[pointIndex].data.toString()}\n${pointIndex == 4 ? "Cubic Feet" : pointIndex == 3 ? "Ltr" : "Kgs"}",
                                style: TextStyle(fontSize: 8));
                          },
                          overflowMode: OverflowMode.trim,
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside))
                ]),
            // Container(
            //   height: 200,
            //   child: RawScrollbar(
            //     trackVisibility: true,
            //     thumbColor: Colors.green.shade100,
            //     thickness: 5,
            //     child: GridView.builder(
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         mainAxisSpacing: 20,
            //         crossAxisSpacing: 20,
            //         crossAxisCount: 3,
            //       ),
            //       itemCount: widget.environmentSaving.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Container(
            //           decoration: BoxDecoration(
            //               color: index == 0
            //                   ? Colors.blue
            //                   : index == 1
            //                       ? Colors.red
            //                       : index == 2
            //                           ? Colors.purple
            //                           : index == 3
            //                               ? Colors.indigo
            //                               : index == 4
            //                                   ? Colors.brown
            //                                   : Colors.grey,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 widget.environmentSaving[index].label.toString(),
            //                 textAlign: TextAlign.center,
            //                 style: GoogleFonts.roboto(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 10),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Text(
            //                 widget.environmentSaving[index].data.toString(),
            //                 textAlign: TextAlign.center,
            //                 style: GoogleFonts.roboto(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 10),
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               Text(
            //                 index == 4
            //                     ? "Cubic Feet"
            //                     : index == 3
            //                         ? "Ltr"
            //                         : "Kgs",
            //                 textAlign: TextAlign.center,
            //                 style: GoogleFonts.roboto(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 10),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
