import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/models/dashboard_gender_count_model.dart';

class GenderCountWidget extends StatefulWidget {
  final List<DashboardGenderCountModel> genderCount;
  const GenderCountWidget({super.key, required this.genderCount});

  @override
  State<GenderCountWidget> createState() => _GenderCountWidgetState();
}

class _GenderCountWidgetState extends State<GenderCountWidget> {
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildItem(widget.genderCount[0]),
                  buildItem(widget.genderCount[1]),
                ],
              ),
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
