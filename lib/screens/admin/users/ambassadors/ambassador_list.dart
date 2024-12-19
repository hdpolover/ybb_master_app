import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/ambassador_service.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/admin/users/widgets/ambassador_preview_widget.dart';

import '../../../../providers/ambassador_provider.dart';

class AmbassadorList extends StatefulWidget {
  const AmbassadorList({super.key});

  @override
  State<AmbassadorList> createState() => _AmbassadorListState();
}

class _AmbassadorListState extends State<AmbassadorList> {
  List<AmbassadorModel> ambassadors = [];

  Map<String, List<ParticipantModel>> participants = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getAmbass();
    getPayments();
  }

  getPayments() async {
    String id = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id
        .toString();

    // get payment data
    await PaymentService().getAll(id).then((value) async {
      Provider.of<PaymentProvider>(context, listen: false).payments = value;
    });
  }

  getAmbass() async {
    setState(() {
      isLoading = true;
    });

    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id
        .toString();

    var ambProvider = Provider.of<AmbassadorProvider>(context, listen: false);

    // get the data
    if (ambassadors.isEmpty) {
      // get the data
      await AmbassadorService().getAllByProgram(programId).then((value) async {
        setState(() {
          ambassadors = value;
        });

        for (var amb in ambassadors) {
          if (amb.refCode == null) {
            continue;
          }

          await AmbassadorService()
              .getReferredParticipants(amb.refCode!)
              .then((value) {
            participants[amb.refCode!] = value;
          });
        }

        // sort the ambassadors based on the number of participants
        ambassadors.sort((a, b) {
          return participants[b.refCode!]!
              .length
              .compareTo(participants[a.refCode!]!.length);
        });

        ambProvider.ambassadors = ambassadors;

        isLoading = false;

        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var ambassadorProvider = Provider.of<AmbassadorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Ambassadors"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRouteConstants.ambassadorAddRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? const Center(child: LoadingWidget())
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ambassadorProvider.ambassadors.isEmpty
                        ? const Center(
                            child: Text("No ambassadors to be shown"))
                        : ListView.builder(
                            itemCount: ambassadorProvider.ambassadors.length,
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              return AmbassadorPreviewWidget(
                                  ambassador:
                                      ambassadorProvider.ambassadors[index],
                                  participants: participants[ambassadorProvider
                                          .ambassadors[index].refCode!] ??
                                      []);
                            },
                          ),
                  ),
                )
        ],
      ),
    );
  }
}
