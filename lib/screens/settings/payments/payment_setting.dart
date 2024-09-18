import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/helpers/common_helper.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/settings/item_widget_tile.dart';

class PaymentSetting extends StatefulWidget {
  const PaymentSetting({super.key});

  @override
  State<PaymentSetting> createState() => _PaymentSettingState();
}

class _PaymentSettingState extends State<PaymentSetting> {
  @override
  void initState() {
    super.initState();

    getPayments();
  }

  Future<void> getPayments() async {
    // Get program ID
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    // Get payments from database
    await ProgramPaymentService().getAll(programId).then((value) {
      Provider.of<ProgramProvider>(context, listen: false).programPayments =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<ProgramPaymentModel>? programPayments =
        programProvider.programPayments;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Program Payments"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment
          context.pushNamed(AppRouteConstants.addEditPaymentRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: programPayments == null
          ? const LoadingWidget()
          : programPayments.isEmpty
              ? const Center(
                  child: Text("No payments found"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  itemCount: programPayments.length,
                  itemBuilder: (context, index) {
                    return ItemWidgetTile(
                      onTap: () {
                        // Edit payment
                        context.pushNamed(
                            AppRouteConstants.paymentSettingDetailRouteName,
                            extra: programPayments[index]);
                      },
                      id: programPayments[index].id!,
                      title:
                          "${programPayments[index].name!}\n[${CommonMethods.formatDateDisplay(programPayments[index].startDate!, programPayments[index].endDate!)}]",
                      description: programPayments[index].category!,
                      moreDesc: CommonHelper().formatMoney(
                              double.parse(programPayments[index].idrAmount!)) +
                          " / " +
                          CommonHelper().formatMoney(
                              double.parse(programPayments[index].usdAmount!)),
                    );
                  },
                ),
    );
  }
}
