import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_certificate_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/settings/item_widget_tile.dart';

class ProgramCertificateSetting extends StatefulWidget {
  const ProgramCertificateSetting({super.key});

  @override
  State<ProgramCertificateSetting> createState() =>
      _ProgramCertificateSettingState();
}

class _ProgramCertificateSettingState extends State<ProgramCertificateSetting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCerts();
  }

  getCerts() async {
    // Get program ID
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await ProgramCertificateService().getAll(programId).then((value) {
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
      appBar: const CommonAppBar(title: "Program Certificates"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment
          context.pushNamed(
              AppRouteConstants.addEditProgramCertificatelineRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: programCertificates == null
            ? const LoadingWidget()
            : ListView.builder(
                itemCount: programCertificates.length,
                itemBuilder: (context, index) {
                  return ItemWidgetTile(
                    id: programCertificates[index].id!,
                    title: programCertificates[index].title!,
                    description: programCertificates[index].description!,
                    moreDesc: "",
                    onTap: () {
                      context.pushNamed(
                          AppRouteConstants.programCertificateDetailRouteName,
                          extra: programCertificates[index]);
                    },
                  );
                },
              ),
      ),
    );
  }
}
