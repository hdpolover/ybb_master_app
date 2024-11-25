import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/routes/router_config.dart';
import 'package:ybb_master_app/core/services/program_certificate_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';

import '../../../core/routes/route_constants.dart';

class ProgramCertificates extends StatefulWidget {
  const ProgramCertificates({super.key});

  @override
  State<ProgramCertificates> createState() => _ProgramCertificatesState();
}

class _ProgramCertificatesState extends State<ProgramCertificates> {
  initState() {
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    //get data
    await ProgramCertificateService().getAll(programId).then((value) {
      //set data
      Provider.of<ProgramProvider>(context, listen: false).programCertificates =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<ProgramCertificateModel>? programCertificates =
        programProvider.programCertificates;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(
        title: "Certificates",
      ),
      body: programCertificates == null
          ? const LoadingWidget()
          : programCertificates.isEmpty
              ? const Center(
                  child: Text("No certificates available"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: programCertificates.length,
                  itemBuilder: (context, index) {
                    return ItemWidgetTile(
                      id: programCertificates[index].id!,
                      title: programCertificates[index].title!,
                      description: programCertificates[index].description!,
                      moreDesc: "",
                      onTap: () {
                        //navigate to detail page
                        context.pushNamed(
                          AppRouteConstants.programCertificateDetailRouteName,
                          extra: programCertificates[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
