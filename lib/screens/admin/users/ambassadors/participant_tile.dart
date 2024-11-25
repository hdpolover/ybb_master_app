import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/services/program_payment_service.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class ParticipantTile extends StatefulWidget {
  final ParticipantModel participantModel;
  const ParticipantTile({super.key, required this.participantModel});

  @override
  State<ParticipantTile> createState() => _ParticipantTileState();
}

class _ParticipantTileState extends State<ParticipantTile> {
  Map<String, String> paymentData = {};
  List<ProgramPaymentModel> payments = [];

  @override
  void initState() {
    super.initState();

    getPaymentData();
  }

  Future<void> getPaymentData() async {
    String id = Provider.of<ProgramProvider>(context, listen: false)
        .currentProgram!
        .id!;

    // get payments
    await ProgramPaymentService().getAll(id).then((value) async {
      setState(() {
        payments = value;
      });

      // get payment data
      List<FullPaymentModel> fullPayment =
          Provider.of<PaymentProvider>(context, listen: false).payments;

      List<FullPaymentModel> participantPayments = fullPayment
          .where(
              (element) => element.participantId == widget.participantModel.id)
          .toList();

      for (var a in participantPayments) {
        for (var b in payments) {
          if (a.programPaymentId == b.id && a.status == "2") {
            paymentData[b.name!] = "V";
          } else {
            paymentData[b.name!] = "X";
          }
        }
        setState(() {});
      }
    });
  }

  buildPaymentList() {
    List<Widget> paymentTiles = [];

    for (var a in payments) {
      paymentTiles.add(
        Text("${a.name ?? "-"} : ${paymentData[a.name] ?? "-"}"),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: paymentTiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    // create a card for each participant
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.participantModel.fullName ?? "-",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                Text(widget.participantModel.email ?? "-"),
              ],
            ),
            buildPaymentList(),
          ],
        ),
      ),
    );
  }
}
