import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/dashboard_gender_count_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ybb_master_app/screens/admin/dashboard/chart_indicator.dart';

class GenderCountWidget extends StatefulWidget {
  final List<DashboardGenderCountModel> genderCount;
  const GenderCountWidget({super.key, required this.genderCount});

  @override
  State<GenderCountWidget> createState() => _GenderCountWidgetState();
}

class _GenderCountWidgetState extends State<GenderCountWidget> {
  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    // create list view builder
    List<DashboardGenderCountModel> genderCount = widget.genderCount;

    List<PieChartSectionData> data = [];

    double percentage = 0.0;

    for (int i = 0; i < genderCount.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      double count = double.parse(
          genderCount[i].jumlah.toString().replaceAll(RegExp(r'[^\w\s]+'), ''));

      if (i == 0) {
        percentage = count /
            (count +
                double.parse(genderCount[1]
                    .jumlah
                    .toString()
                    .replaceAll(RegExp(r'[^\w\s]+'), '')));
      } else {
        percentage = count /
            (count +
                double.parse(genderCount[0]
                    .jumlah
                    .toString()
                    .replaceAll(RegExp(r'[^\w\s]+'), '')));
      }

      // percentage + "%" + " (count)"
      String titleText = "${(percentage * 100).toStringAsFixed(2)}%"
          "\n(${genderCount[i].jumlah})";

      data.add(PieChartSectionData(
        color: i == 0 ? Colors.blue : Colors.pink,
        value: percentage,
        title: titleText,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      ));
    }

    return data;
    // return List.generate(2, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 16.0;
    //   final radius = isTouched ? 60.0 : 50.0;
    //   const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: Colors.blue,
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: Colors.pink,
    //         value: 30,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  }

  buildItem(DashboardGenderCountModel item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              item.gender!,
              style: AppTextStyleConstants.headingTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              item.jumlah!,
              style: AppTextStyleConstants.bodyTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  buildChart() {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 20,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ChartIndicator(
                color: Colors.blue,
                text: 'Male',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              ChartIndicator(
                color: Colors.pink,
                text: 'Female',
                isSquare: true,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Participants by Gender",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              buildChart(),
              const SizedBox(height: 20),
              const Text(
                "Keep in mind that MALE is the default value when participants first registered. This data is not entirely accurate.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
