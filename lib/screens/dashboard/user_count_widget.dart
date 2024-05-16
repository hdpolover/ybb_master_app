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

    today = widget.userCount.firstWhere((element) =>
        DateFormat('dd MMM yyyy').format(element.tanggal!) ==
        DateFormat('dd MMM yyyy').format(DateTime.now()));

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Card(
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
              Text(
                "Today: ${today!.jumlah} (${DateFormat('dd MMM yyyy').format(today!.tanggal!)})",
                style: AppTextStyleConstants.headingTextStyle
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.userCount.length,
                  itemBuilder: (context, index) {
                    return buildItem(widget.userCount[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
