import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/dashboard_controller.dart';

class SegregateScreendata extends StatefulWidget {
  const SegregateScreendata({
    super.key,
    required this.dateRange,
    required this.segredateddata,
  });
  final DateTimeRange dateRange;
  final List segredateddata;
  @override
  State<SegregateScreendata> createState() => _StatisticsState();
}

class _StatisticsState extends State<SegregateScreendata> {
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
                      "Segregated Data",
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
            const SizedBox(height: 12),
            Container(
              height: 200,
              child: ListView.builder(
                itemCount: widget.segredateddata.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tower No"),
                                Text(widget.segredateddata[index]["ad1"] ?? ""),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Records"),
                                Text(widget.segredateddata[index]
                                        ["total_records"]
                                    .toString()),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Collections"),
                                Text(widget.segredateddata[index]["total"] ??
                                    ""),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Segregated"),
                                Text(widget.segredateddata[index]
                                        ["segregated"] ??
                                    ""),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Percentage"),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.segredateddata[index]["percentage"]
                                              .toString() +
                                          " %",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      );
    });
  }
}
