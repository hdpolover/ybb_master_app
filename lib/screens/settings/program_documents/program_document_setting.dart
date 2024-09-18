import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_document_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/settings/item_widget_tile.dart';

class ProgamDocumentSetting extends StatefulWidget {
  const ProgamDocumentSetting({super.key});

  @override
  State<ProgamDocumentSetting> createState() => _ProgamDocumentSettingState();
}

class _ProgamDocumentSettingState extends State<ProgamDocumentSetting> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await ProgramDocumentService().getAll(programId).then((value) {
      Provider.of<ProgramProvider>(context, listen: false).programDocuments =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<ProgramDocumentModel>? programDocuments =
        programProvider.programDocuments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Program Documents"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment method
          context.pushNamed(AppRouteConstants.addEditProgramDocumentRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: programDocuments == null
          ? const LoadingWidget()
          : programDocuments.isEmpty
              ? const Center(
                  child: Text("No program documents found"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: programDocuments.length,
                  itemBuilder: (context, index) {
                    return ItemWidgetTile(
                      id: programDocuments[index].id!,
                      title: programDocuments[index].name!,
                      description: programDocuments[index].desc!,
                      moreDesc: "",
                      onTap: () {
                        // Edit payment method
                        context.pushNamed(
                          AppRouteConstants.programDocumentDetailRouteName,
                          extra: programDocuments[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
