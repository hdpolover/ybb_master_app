import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';

class PaymentStatistics extends StatefulWidget {
  const PaymentStatistics({super.key});

  @override
  State<PaymentStatistics> createState() => _PaymentStatisticsState();
}

class _PaymentStatisticsState extends State<PaymentStatistics> {
  buildPaymentTotalItem(String title, int total) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          total.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  buildPaymentStatusStats(PaymentProvider paymentProvider) {
    // List<ProgramPaymentModel> programPayments = paymentProvider.;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildPaymentTotalItem(
                "Total Payments", paymentProvider.payments.length),
            buildPaymentTotalItem(
                "Created Payments",
                paymentProvider.payments
                    .where((payment) => payment.status == "0")
                    .length),
            buildPaymentTotalItem(
                "Pending Payments",
                paymentProvider.payments
                    .where((payment) => payment.status == "1")
                    .length),
            buildPaymentTotalItem(
                "Successful Payments",
                paymentProvider.payments
                    .where((payment) => payment.status == "2")
                    .length),
            buildPaymentTotalItem(
                "Failed/Rejected Payments",
                paymentProvider.payments
                    .where((payment) =>
                        payment.status == "3" || payment.status == "4")
                    .length),
          ],
        ),
      ],
    );
  }

  buildProgramPaymentStatusSection(
      String programPaymentName, Map<String, dynamic> data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              programPaymentName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        data['status'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['total'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildPaymentNumberByDates(PaymentProvider paymentProvider) {
    // get list of payments
    List<FullPaymentModel> payments = paymentProvider.payments;

    // get list of payment dates and make sure they are not duplicated. ignore the time
    List<DateTime> paymentDates = payments
        .map((payment) => DateTime(payment.createdAt!.year,
            payment.createdAt!.month, payment.createdAt!.day))
        .toSet()
        .toList();

    // get list of payment counts for each date
    Map<String, double> paymentTotalByDate = {};

    for (DateTime date in paymentDates) {
      double total = 0;

      for (FullPaymentModel payment in payments) {
        DateTime paymentDate = DateTime(payment.createdAt!.year,
            payment.createdAt!.month, payment.createdAt!.day);

        if (date == paymentDate) {
          total++;
        }
      }

      String formattedDate = DateFormat('dd MMM yyyy').format(date);

      paymentTotalByDate[formattedDate] = total;
    }

    // Sort the paymentTotalByDate by date from earliest to latest
    paymentTotalByDate = Map.fromEntries(paymentTotalByDate.entries.toList()
      ..sort((a, b) {
        DateTime dateA = DateFormat('dd MMM yyyy').parse(a.key);
        DateTime dateB = DateFormat('dd MMM yyyy').parse(b.key);

        return dateA.compareTo(dateB);
      }));

    // Extracting all 'jumlah' values for normalization
    final List<double> totalValues = paymentTotalByDate.values.toList();

    // Find the minimum and maximum values for normalization
    final double minValue = totalValues.reduce((a, b) => a < b ? a : b);
    final double maxValue = totalValues.reduce((a, b) => a > b ? a : b);

    // Normalizing the data between 0 and 1
    final List<double> normalizedValues = totalValues.map((e) {
      return (e - minValue) / (maxValue - minValue);
    }).toList();

    // Create FlSpot points for LineChart
    List<FlSpot> spots = normalizedValues.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value * 100; // Scaling for better display (0 to 100)
      return FlSpot(index.toDouble(), value);
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Number by Dates",
            style: AppTextStyleConstants.headingTextStyle.copyWith(
              fontSize: 20,
            ),
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

                        // Get the total value
                        final total = totalValues[spotIndex];

                        // Get the date
                        final tanggal =
                            paymentTotalByDate.keys.toList()[spotIndex];

                        return LineTooltipItem(
                          '$total\n($tanggal)',
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var paymentProvider = Provider.of<PaymentProvider>(context);
    return Scaffold(
      appBar: const CommonAppBar(title: "Payment Statistics"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPaymentNumberByDates(paymentProvider),
              const SizedBox(height: 20),
              buildPaymentStatusStats(paymentProvider),
            ],
          ),
        ),
      ),
    );
  }
}
