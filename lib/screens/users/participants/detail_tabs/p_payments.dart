import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/payment_xendit_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/screens/payments/payment_card.dart';

class PPayments extends StatefulWidget {
  final ParticipantModel participant;
  const PPayments({super.key, required this.participant});

  @override
  State<PPayments> createState() => _PPaymentsState();
}

class _PPaymentsState extends State<PPayments> {
  List<FullPaymentModel>? payments;
  List<PaymentXenditModel>? xenditPayments;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    // get the data
    await PaymentService()
        .getByParticipantId(widget.participant.id!)
        .then((value) async {
      payments = value;

      payments!.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      setState(() {});
    }).onError((error, stackTrace) {
      setState(() {
        payments = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return payments == null
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: payments!.isEmpty
                ? const Center(
                    child:
                        Text("This participant hasn't made any payments yet."))
                : ListView.builder(
                    itemCount: payments!.length,
                    itemBuilder: (context, index) {
                      return PaymentCard(
                        payment: payments![index],
                      );
                    },
                  ),
          );
  }
}
