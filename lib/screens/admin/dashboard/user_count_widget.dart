import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/dashboard_user_count_model.dart';

class UserCountWidget extends StatefulWidget {
  final List<DashboardUserCountModel> userCount;
  const UserCountWidget({super.key, required this.userCount});

  @override
  State<UserCountWidget> createState() => _UserCountWidgetState();
}

class _UserCountWidgetState extends State<UserCountWidget> {
  int totalParticipants = 0;
  DashboardUserCountModel? highestUser;
  DashboardUserCountModel? lowestUser;
  DashboardUserCountModel? today;
  int averageUser = 0;

  @override
  void initState() {
    super.initState();

    setData();
  }

  setData() {
    int total = 0;
    for (var i in widget.userCount) {
      total += int.parse(i.jumlah!);
    }

    totalParticipants = total;

    highestUser = widget.userCount.reduce((current, next) {
      if (int.parse(current.jumlah!) > int.parse(next.jumlah!)) {
        return current;
      } else {
        return next;
      }
    });

    lowestUser = widget.userCount.reduce((current, next) {
      if (int.parse(current.jumlah!) < int.parse(next.jumlah!)) {
        return current;
      } else {
        return next;
      }
    });

    // check if user count conains today's date
    if (widget.userCount.any((element) =>
        DateFormat('dd MMM yyyy').format(element.tanggal!) ==
        DateFormat('dd MMM yyyy').format(DateTime.now()))) {
      today = widget.userCount.firstWhere((element) =>
          DateFormat('dd MMM yyyy').format(element.tanggal!) ==
          DateFormat('dd MMM yyyy').format(DateTime.now()));
    } else {
      today = null;
    }

    averageUser = totalParticipants ~/ widget.userCount.length;

    setState(() {});
  }

  buildItem(DashboardUserCountModel item) {
    // build a container card for each item
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColorConstants.kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd MMM yyyy').format(item.tanggal!),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.jumlah!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    String text;

    // Ensure that the value corresponds to a valid index in the dates array
    if (value.toInt() >= 0 && value.toInt() < widget.userCount.length) {
      text = DateFormat('dd/mm').format(widget
          .userCount[value.toInt()].tanggal!); // Extract MM-DD for display
    } else {
      text = ''; // Default to empty if out of range
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      // space: 4, // You can adjust space for better fitting
      fitInside: SideTitleFitInsideData.fromTitleMeta(
        meta,
        distanceFromEdge: 0,
      ),
      child: Text(text, style: style),
    );
  }

  // Function to show real jumlah values on the left axis
  Widget getLeftTitles(
      double value, TitleMeta meta, double minValue, double maxValue) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    // Only show the titles for real jumlah values based on interval
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(value.toStringAsFixed(0), style: style),
    );
  }

  // Function to calculate the appropriate interval based on jumlah values
  double getYInterval(double minValue, double maxValue) {
    // Set an interval that makes sense for the range of the values
    double range = maxValue - minValue;
    if (range > 500) {
      return 100; // Large range, use interval of 100
    } else if (range > 100) {
      return 50; // Medium range, use interval of 50
    } else if (range > 50) {
      return 10; // Small range, use interval of 10
    } else {
      return 5; // Very small range, use interval of 5
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extracting all 'jumlah' values for normalization
    final List<double> jumlahValues =
        widget.userCount.map((e) => double.parse(e.jumlah!)).toList();

    // Find the minimum and maximum values for normalization
    final double minValue = jumlahValues.reduce((a, b) => a < b ? a : b);
    final double maxValue = jumlahValues.reduce((a, b) => a > b ? a : b);

    // Normalizing the data between 0 and 1
    final List<double> normalizedValues = jumlahValues.map((e) {
      return (e - minValue) / (maxValue - minValue);
    }).toList();

    // Create FlSpot points for LineChart
    List<FlSpot> spots = normalizedValues.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value * 100; // Scaling for better display (0 to 100)
      return FlSpot(index.toDouble(), value);
    }).toList();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            const Text(
              "Participants by Register Dates",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total: $totalParticipants"),
                const SizedBox(width: 8),
                Text(
                    "Highest: ${highestUser!.jumlah} (${DateFormat('dd MMM yyyy').format(highestUser!.tanggal!)})"),
                const SizedBox(width: 8),
                Text("Average: $averageUser"
                    // "Average Participants: ${averageUser.toStringAsFixed(2)}",
                    ),
              ],
            ),
            const SizedBox(height: 10),
            if (today != null)
              Text(
                "Today: ${today!.jumlah} (${DateFormat('dd MMM yyyy').format(today!.tanggal!)})",
                style: AppTextStyleConstants.headingTextStyle
                    .copyWith(fontSize: 20),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                          show: true, color: Colors.blue.withOpacity(0.3)),
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // bottomTitles: AxisTitles(
                    //   sideTitles: SideTitles(
                    //     showTitles: true,
                    //     reservedSize: 30,
                    //     getTitlesWidget: getTitles,
                    //   ),
                    // ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // leftTitles: AxisTitles(
                    //   sideTitles: SideTitles(
                    //     showTitles: true,
                    //     getTitlesWidget: (value, meta) =>
                    //         getLeftTitles(value, meta, minValue, maxValue),
                    //     interval: getYInterval(
                    //         minValue, maxValue), // Set an appropriate interval
                    //     reservedSize: 40,
                    //   ),
                    // ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: true),
                  lineTouchData: LineTouchData(
                    enabled: true, // Enable touch interaction
                    getTouchedSpotIndicator: (barData, spotIndexes) {
                      return spotIndexes.map((index) {
                        return const TouchedSpotIndicatorData(
                          FlLine(
                              color: Color.fromARGB(255, 61, 61, 61),
                              strokeWidth: 2),
                          FlDotData(show: true),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((touchedSpot) {
                          final int spotIndex = touchedSpot.spotIndex;

                          // format the date to display in the tooltip
                          String formattedDate = DateFormat('dd MMM yyyy')
                              .format(widget.userCount[spotIndex].tanggal!);

                          final String jumlah =
                              widget.userCount[spotIndex].jumlah.toString();

                          return LineTooltipItem(
                            '$jumlah\n($formattedDate)',
                            const TextStyle(color: Colors.white, fontSize: 16),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  // minY: minValue,
                  // maxY: maxValue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
