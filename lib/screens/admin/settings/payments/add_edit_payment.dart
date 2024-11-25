import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

import '../../../../core/services/program_payment_service.dart';

class AddEditPayment extends StatefulWidget {
  final ProgramPaymentModel? payment;

  const AddEditPayment({super.key, this.payment});

  @override
  State<AddEditPayment> createState() => _AddEditPaymentState();
}

class _AddEditPaymentState extends State<AddEditPayment> {
  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _descKey = GlobalKey<FormBuilderFieldState>();
  final _idrAmountKey = GlobalKey<FormBuilderFieldState>();
  final _usdAmountKey = GlobalKey<FormBuilderFieldState>();
  final _startDateKey = GlobalKey<FormBuilderFieldState>();
  final _endDateKey = GlobalKey<FormBuilderFieldState>();
  final _dropdownKey = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  String? paymentName, paymentDesc, paymentIdr, paymentUsd, paymentCategory;

  DateTime? paymentStartDate, paymentEndDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setValue();
  }

  void setValue() {
    if (widget.payment != null) {
      paymentName = widget.payment!.name;
      paymentDesc = widget.payment!.description;
      paymentIdr = widget.payment!.idrAmount.toString();
      paymentUsd = widget.payment!.usdAmount.toString();
      paymentStartDate = widget.payment!.startDate;
      paymentEndDate = widget.payment!.endDate;
      paymentCategory = widget.payment!.category;
    }
  }

  getDropdownItems() {
    Map<String, String> items = {
      "registration": "Registration",
      "program_fee_1": "Program Fee 1",
      "program_fee_2": "Program Fee 2",
    };

    List<DropdownMenuItem<String>> dropdownItems = [];

    items.forEach((key, value) {
      dropdownItems.add(
        DropdownMenuItem(
          value: key,
          child: Text(value),
        ),
      );
    });

    return dropdownItems;
  }

  save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      ProgramPaymentModel payment = ProgramPaymentModel(
        programId: Provider.of<ProgramProvider>(context, listen: false)
            .currentProgram!
            .id,
        name: _nameKey.currentState!.value,
        description: _descKey.currentState!.value,
        startDate: _startDateKey.currentState!.value,
        endDate: _endDateKey.currentState!.value,
        idrAmount: _idrAmountKey.currentState!.value,
        usdAmount: _usdAmountKey.currentState!.value,
        category: _dropdownKey.currentState!.value,
        orderNumber: "1",
      );

      if (widget.payment != null) {
        payment.id = widget.payment!.id;

        await ProgramPaymentService().update(payment).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment updated successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .updateProgramPayment(value);

          Navigator.pop(context);
        }).catchError((e, s) {
          print(s);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        });
      } else {
        await ProgramPaymentService().add(payment).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment added successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .addProgramPayment(value);

          Navigator.pop(context);
        }).catchError((e, s) {
          print(s);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
          title: widget.payment == null ? "Add Payment" : "Edit Payment"),
      body: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                CommonWidgets().buildTextField(
                  _nameKey,
                  "name",
                  "Payment Name",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: paymentName ?? "",
                ),
                CommonWidgets().buildTextField(
                  _descKey,
                  "description",
                  "Payment Description",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                  ],
                  initial: paymentDesc ?? "",
                ),
                CommonWidgets().buildTextField(
                  _idrAmountKey,
                  "idr_amount",
                  "IDR Amount",
                  [
                    FormBuilderValidators.required(),
                    (value) {
                      // check if value is a number
                      // if not, return error message
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    }
                  ],
                  initial: paymentIdr ?? "",
                ),
                CommonWidgets().buildTextField(
                  _usdAmountKey,
                  "usd_amount",
                  "USD Amount",
                  [
                    FormBuilderValidators.required(),
                    (value) {
                      // check if value is a number
                      // if not, return error message
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid number";
                      }
                      return null;
                    }
                  ],
                  initial: paymentUsd ?? "",
                ),
                CommonWidgets().buildDateField(
                  _startDateKey,
                  "start_date",
                  "Start Date",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: paymentStartDate,
                ),
                CommonWidgets().buildDateField(
                  _endDateKey,
                  "end_date",
                  "End Date",
                  [
                    FormBuilderValidators.required(),
                    // end date cannot be before start date
                    (value) {
                      if (value.isBefore(_startDateKey.currentState!.value)) {
                        return "End date cannot be before start date";
                      }
                      return null;
                    }
                  ],
                  initial: paymentEndDate,
                ),
                CommonWidgets().buildDropdownField(
                  _dropdownKey,
                  "category",
                  "Category",
                  [
                    FormBuilderValidators.required(),
                  ],
                  getDropdownItems(),
                  initial: paymentCategory ?? "",
                ),
                isLoading
                    ? const LoadingWidget()
                    : CommonWidgets().buildCustomButton(
                        text: "Save",
                        onPressed: () {
                          save();
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
