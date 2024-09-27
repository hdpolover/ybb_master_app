import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';
import 'package:ybb_master_app/screens/payments/payment_card.dart';

class PPayments extends StatelessWidget {
  final ParticipantModel participant;
  const PPayments({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    var participantProvider = Provider.of<ParticipantProvider>(context);

    List<FullPaymentModel> payments =
        participantProvider.selectedParticipantPayments;

    payments.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: payments.isEmpty
          ? const Center(
              child: Text("This participant hasn't made any payments yet."))
          : ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                return PaymentCard(
                  payment: payments[index],
                );
              },
            ),
    );
  }
}
