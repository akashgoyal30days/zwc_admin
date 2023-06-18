import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:zwc/controllers/dashboard_controller.dart';

class MembersDataScreen extends StatefulWidget {
  const MembersDataScreen(
      {super.key, required this.dateRange, required this.membersdata});
  final MembersData? membersdata;
  final DateTimeRange dateRange;
  @override
  State<MembersDataScreen> createState() => _MembersDataScreenState();
}

class _MembersDataScreenState extends State<MembersDataScreen> {
  @override
  void initState() {
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
              "ZWC Members",
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
            PieChart(
              dataMap: {
                "Accounts": double.parse(
                    widget.membersdata!.totalcitizens.toString() == "null"
                        ? "0"
                        : widget.membersdata!.totalcitizens.toString()),
                "Recyclers": double.parse(
                    widget.membersdata!.totalrecyclers.toString() == "null"
                        ? "0"
                        : widget.membersdata!.totalrecyclers.toString()),
                "Warriors": double.parse(
                    widget.membersdata!.totalwarriors.toString() == "null"
                        ? "0"
                        : widget.membersdata!.totalwarriors.toString()),
                "Collectors": double.parse(
                    widget.membersdata!.totalcollectors.toString()),
                "Aggregators": double.parse(
                    widget.membersdata!.totalaggregator.toString()),
              },
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              chartRadius: MediaQuery.of(context).size.width * 0.4,
              initialAngleInDegree: 10,
              chartType: ChartType.ring,
              centerText: "ZWC",
              ringStrokeWidth: 32,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.rectangle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
