import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zwc/model/getstockreportbycategorymodel.dart';

class Drywasteoverview extends StatefulWidget {
  const Drywasteoverview(
      {super.key,
      required this.dateRange,
      required this.stockdata,
      this.totaldrywaste});
  final List<Categorystockdata>? stockdata;
  final DateTimeRange dateRange;
  final String? totaldrywaste;
  @override
  State<Drywasteoverview> createState() => _DrywasteoverviewState();
}

class _DrywasteoverviewState extends State<Drywasteoverview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.stockdata!.isEmpty
        ? SizedBox()
        : Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Overview",
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
                  const SizedBox(height: 16),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.5,
                                crossAxisCount: 3,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0),
                        padding: EdgeInsets.zero,
                        itemCount: widget.stockdata!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.network(widget
                                            .stockdata![index].categoryImage
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.stockdata![index].inQuantity
                                                .toString()
                                                .contains(".")
                                            ? "${widget.stockdata![index].inQuantity.toString().split(".").first.toString()} KGs"
                                            : "${widget.stockdata![index].inQuantity} KGs",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            color: Colors.black87,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${widget.stockdata![index].categoryName}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total Dry Waste : ${widget.totaldrywaste} KGs",
                    style: GoogleFonts.roboto(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
