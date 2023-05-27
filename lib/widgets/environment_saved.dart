import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  @override
  void initState() {
    currentSelection = widget.environmentSaving;
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
              "Environmental Saving",
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
                      text:
                          DateFormat("d MMMM").format(widget.dateRange.start)),
                  const TextSpan(text: " - "),
                  TextSpan(
                      text: DateFormat("d MMMM").format(widget.dateRange.end)),
                ])),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: RawScrollbar(
                trackVisibility: true,
                thumbColor: Colors.green.shade100,
                thickness: 5,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 3,
                  ),
                  itemCount: widget.environmentSaving.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: index == 0
                              ? Colors.blue
                              : index == 1
                                  ? Colors.red
                                  : index == 2
                                      ? Colors.purple
                                      : index == 3
                                          ? Colors.indigo
                                          : index == 4
                                              ? Colors.brown
                                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.environmentSaving[index].label.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.environmentSaving[index].data.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnvironmentalSavingWidgets extends StatelessWidget {
  const EnvironmentalSavingWidgets({
    Key? key,
    required this.title,
    required this.icon,
    required this.units,
    required this.value,
    required this.color,
  }) : super(key: key);
  final String title, units;
  final IconData icon;
  final dynamic value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(style: TextStyle(color: color), children: [
                      TextSpan(
                        text: value.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: " $units",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ])),
                const SizedBox(width: 6),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "of ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.black),
                      ),
                      TextSpan(
                        text: title,
                        style: GoogleFonts.montserrat(color: Colors.black),
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
