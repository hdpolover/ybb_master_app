import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/payment_method_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

import '../../../core/services/program_payment_service.dart';

class AddEditPaymentMethod extends StatefulWidget {
  final PaymentMethodModel? paymentMethod;

  const AddEditPaymentMethod({super.key, this.paymentMethod});

  @override
  State<AddEditPaymentMethod> createState() => _AddEditPaymentMethodState();
}

class _AddEditPaymentMethodState extends State<AddEditPaymentMethod> {
  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _descKey = GlobalKey<FormBuilderFieldState>();
  final _idrAmountKey = GlobalKey<FormBuilderFieldState>();
  final _usdAmountKey = GlobalKey<FormBuilderFieldState>();
  final _startDateKey = GlobalKey<FormBuilderFieldState>();
  final _endDateKey = GlobalKey<FormBuilderFieldState>();
  final _dropdownKey = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  final QuillController _controller = QuillController.basic();

  String? paymentName, paymentDesc, paymentIdr, paymentUsd, paymentCategory;

  DateTime? paymentStartDate, paymentEndDate;

  bool isLoading = false;

  FilePickerResult? photoFile;
  Uint8List? fileBytes;
  String? fileName;
  String? profileUrl;

  @override
  void initState() {
    super.initState();

    setValue();
  }

  void setValue() {
    // if (widget.paymentMethod != null) {
    //   paymentName = widget.paymentMethod!.name;
    //   paymentDesc = widget.paymentMethod!.description;
    //   paymentIdr = widget.paymentMethod!.idrAmount.toString();
    //   paymentUsd = widget.paymentMethod!.usdAmount.toString();
    //   paymentStartDate = widget.paymentMethod!.startDate;
    //   paymentEndDate = widget.paymentMethod!.endDate;
    //   paymentCategory = widget.paymentMethod!.category;
    // }
  }

  getDropdownItems() {
    Map<String, String> items = {
      "manual": "Manual",
      "gateway": "Gateway",
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

      if (widget.paymentMethod != null) {
        payment.id = widget.paymentMethod!.id;

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
          title: widget.paymentMethod == null
              ? "Add Payment Method"
              : "Edit Payment Method"),
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
                  "Payment Method Name",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: paymentName ?? "",
                ),
                CommonWidgets().buildQuilEditor(
                  _controller,
                  "Description",
                  initial: paymentDesc ?? "",
                ),
                CommonWidgets().buildDropdownField(
                  _dropdownKey,
                  "type",
                  "Payment Type",
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
