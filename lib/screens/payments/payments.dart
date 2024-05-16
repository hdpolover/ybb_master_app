import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/services/payment_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/screens/payments/payment_card.dart';

class PaymentFilterChip {
  String label;
  String status;

  PaymentFilterChip({
    required this.label,
    required this.status,
  });
}

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<FullPaymentModel> filteredPayments = [];

  int _selectedIndex = 0;

  List<PaymentFilterChip> filterChips = [
    PaymentFilterChip(
      label: "All",
      status: "all",
    ),
    PaymentFilterChip(
      label: "Created",
      status: "0",
    ),
    PaymentFilterChip(
      label: "Pending",
      status: "1",
    ),
    PaymentFilterChip(
      label: "Paid",
      status: "2",
    ),
    PaymentFilterChip(
      label: "Cancelled",
      status: "3",
    ),
    PaymentFilterChip(
      label: "Rejected",
      status: "4",
    ),
  ];

  @override
  void initState() {
    getPaymentData();

    super.initState();
  }

  getPaymentData() async {
    // get the data
    PaymentService().getAll().then((value) {
      Provider.of<PaymentProvider>(context, listen: false).payments = value;

      setState(() {
        filteredPayments = value;
      });
    });
  }

  buildPaymentDataList(List<FullPaymentModel> payments, String filter) {
    // sort payments by date
    payments.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return Column(
      children: [
        buildStatusChips(payments),
        filteredPayments.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: const Center(
                      child: Text("No payments found"),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredPayments.length,
                  itemBuilder: (context, index) {
                    return PaymentCard(payment: filteredPayments[index]);
                  },
                ),
              ),
      ],
    );
  }

  buildStatusChips(List<FullPaymentModel> payments) {
    List<ChoiceChip> chips = [];

    for (var item in filterChips) {
      int total = item.status == "all"
          ? payments.length
          : payments.where((element) => element.status == item.status).length;

      chips.add(ChoiceChip(
        label: Text("${item.label} ($total)"),
        selected: _selectedIndex == filterChips.indexOf(item) ? true : false,
        onSelected: (value) {
          setState(() {
            _selectedIndex = filterChips.indexOf(item);

            if (item.status == "all") {
              filteredPayments = payments;
            } else {
              filteredPayments = payments
                  .where((element) => element.status == item.status)
                  .toList();
            }
          });
        },
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            children: chips,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var payments = Provider.of<PaymentProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(
        title: "Payments",
      ),
      body: buildPaymentDataList(payments.payments, "email"),
    );
  }
}
