import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/document_batch_model.dart';
import 'package:ybb_master_app/core/services/program_document_setting_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class AddEditDocumentBatch extends StatefulWidget {
  final DocumentBatchModel? documentBatch;

  const AddEditDocumentBatch({super.key, this.documentBatch});

  @override
  State<AddEditDocumentBatch> createState() => _AddEditDocumentBatchState();
}

class _AddEditDocumentBatchState extends State<AddEditDocumentBatch> {
  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _startDateKey = GlobalKey<FormBuilderFieldState>();
  final _endDateKey = GlobalKey<FormBuilderFieldState>();
  final _availabilityDateKey = GlobalKey<FormBuilderFieldState>();
  final _customeAvailabilityKey = GlobalKey<FormBuilderFieldState>();
  final _orderKey = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  String? documentName, customAvailability;

  DateTime? startDate, endDate, availabilityDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setValue();
  }

  void setValue() {
    if (widget.documentBatch != null) {
      documentName = widget.documentBatch!.name;
      startDate = widget.documentBatch!.startDate!;
      endDate = widget.documentBatch!.endDate!;
      availabilityDate = widget.documentBatch!.availabilityDate!;
      customAvailability = widget.documentBatch!.customAvailability;
    }
  }

  save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      DocumentBatchModel documentBatch = DocumentBatchModel(
        programId: Provider.of<ProgramProvider>(context, listen: false)
            .currentProgram!
            .id,
        name: _nameKey.currentState!.value,
        startDate: _startDateKey.currentState!.value,
        endDate: _endDateKey.currentState!.value,
        availabilityDate: _availabilityDateKey.currentState!.value,
        customAvailability: _customeAvailabilityKey.currentState!.value,
      );

      if (widget.documentBatch != null) {
        documentBatch.id = widget.documentBatch!.id;

        await ProgramDocumentSettingService()
            .update(documentBatch)
            .then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document Batch updated successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .updateDocumentBatch(value);

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
        await ProgramDocumentSettingService().add(documentBatch).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Document Batch added successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .addDocumentBatch(value);

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
          title: widget.documentBatch == null
              ? "Add Document Batch"
              : "Edit Document Batch"),
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
                  "Document Batch Name",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: documentName ?? "",
                ),
                CommonWidgets().buildDateField(
                  _startDateKey,
                  "start_date",
                  "Registration Start Date",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: startDate,
                ),
                CommonWidgets().buildDateField(
                  _endDateKey,
                  "end_date",
                  "Registration End Date",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: endDate,
                ),
                CommonWidgets().buildDateField(
                  _availabilityDateKey,
                  "availability_date",
                  "Document Availability Date",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: availabilityDate,
                ),
                CommonWidgets().buildTextField(
                  _customeAvailabilityKey,
                  "custom_availability",
                  "Custom Availability (in days)",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: customAvailability ?? "",
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
