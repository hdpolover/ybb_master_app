import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/constants/color_constants.dart';
import 'package:ybb_master_app/core/constants/size_constants.dart';
import 'package:ybb_master_app/core/constants/text_style_constants.dart';
import 'package:ybb_master_app/core/widgets/common_admin_top_app_bar.dart';

class AddProgram extends StatefulWidget {
  const AddProgram({super.key});

  @override
  State<AddProgram> createState() => _AddProgramState();
}

class _AddProgramState extends State<AddProgram> with TickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAdminTopAppBar(
        height:
            MediaQuery.of(context).size.height * AppSizeConstants.appBarHeight,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Program Settings",
                    style: AppTextStyleConstants.pageTitleTextStyle,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TabBar(
                        controller: _nestedTabController,
                        indicatorColor: AppColorConstants.kPrimaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 5,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            text: "Program Details",
                          ),
                          Tab(
                            text: "Landing Page Settings",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.72,
                        child: TabBarView(
                          controller: _nestedTabController,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blueGrey[300],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blueGrey[300],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                  // Text(
                  //   "Program Name",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program name",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Program Description",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program description",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Program Date",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program date",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Program Time",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program time",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Program Location",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program location",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   "Program Image",
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(height: 10),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter program image",
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
