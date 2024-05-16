import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';

class MasterProgramCategories extends StatefulWidget {
  const MasterProgramCategories({super.key});

  @override
  State<MasterProgramCategories> createState() =>
      _MasterProgramCategoriesState();
}

class _MasterProgramCategoriesState extends State<MasterProgramCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Program Categories",
        isBackEnabled: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [Text("data")]),
      ),
    );
  }
}
