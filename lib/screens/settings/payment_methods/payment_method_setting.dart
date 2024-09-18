import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/payment_method_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/core/services/program_payment_method_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';
import 'package:ybb_master_app/screens/settings/item_widget_tile.dart';

class PaymentMethodSetting extends StatefulWidget {
  const PaymentMethodSetting({super.key});

  @override
  State<PaymentMethodSetting> createState() => _PaymentMethodSettingState();
}

class _PaymentMethodSettingState extends State<PaymentMethodSetting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData() async {
    String programId = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    await ProgramPaymentMethodService().getAll(programId).then((value) {
      Provider.of<ProgramProvider>(context, listen: false).paymentMethods =
          value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);

    List<PaymentMethodModel>? paymentMethods = programProvider.paymentMethods;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Payment Methods"),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add new payment method
          context.pushNamed(AppRouteConstants.addEditPaymentMethodRouteName);
        },
        child: const Icon(Icons.add),
      ),
      body: paymentMethods == null
          ? const LoadingWidget()
          : paymentMethods.isEmpty
              ? const Center(
                  child: Text("No payment methods found"),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    return ItemWidgetTile(
                      id: paymentMethods[index].id!,
                      title: paymentMethods[index].name!,
                      description: paymentMethods[index].description!,
                      moreDesc: "",
                      onTap: () {
                        // Edit payment method
                        context.pushNamed(
                          AppRouteConstants.paymentMethodSettingDetailRouteName,
                          extra: paymentMethods[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
