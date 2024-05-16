import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/dashboad_nationality_count_model.dart';
import 'package:ybb_master_app/screens/dashboard/indicator.dart';

class NationalityCountItem {
  DashboardNationalityCountModel? item;
  Color? color;

  NationalityCountItem({this.item, this.color});
}

class NationalityCountWidget extends StatefulWidget {
  final List<DashboardNationalityCountModel> nationalityList;

  const NationalityCountWidget({super.key, required this.nationalityList});

  @override
  State<StatefulWidget> createState() => NationalityCountWidgetState();
}

class NationalityCountWidgetState extends State<NationalityCountWidget> {
  List<NationalityCountItem> items = [];
  int totalCountries = 0, totalParticipants = 0;

  @override
  void initState() {
    super.initState();

    defineData();
  }

  List<Color> generateUniqueColors(int count) {
    List<Color> colors = [];
    Random random = Random();

    while (colors.length < count) {
      Color newColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );

      // Ensure the color is unique
      if (!colors.contains(newColor)) {
        colors.add(newColor);
      }
    }

    return colors;
  }

  defineData() {
    int total = 0;
    for (var i in widget.nationalityList) {
      total += int.parse(i.jumlah!);
    }

    totalParticipants = total;
    totalCountries = widget.nationalityList.length;

    List<Color> colors = generateUniqueColors(widget.nationalityList.length);

    for (var i in widget.nationalityList) {
      // generate random color
      Color tempColor = colors[widget.nationalityList.indexOf(i)];

      NationalityCountItem item = NationalityCountItem(
        item: i,
        color: tempColor,
      );

      items.add(item);
    }

    // sort by total participants
    items.sort((a, b) {
      return int.parse(b.item!.jumlah!).compareTo(int.parse(a.item!.jumlah!));
    });

    setState(() {});
  }

  buildNationalityItem(NationalityCountItem e) {
    // make a square container with the name of nationality, color, and total
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: e.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              e.item!.nationality ?? "Undefined",
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              e.item!.jumlah!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
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
                "Participants by Nationalities",
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
                  Text("Total Countries: $totalCountries"),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // make a grid view
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return buildNationalityItem(items[index]);
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  "Undefined means these participants have not specified their nationalities"),
            ],
          ),
        ),
      ),
    );
  }
}
