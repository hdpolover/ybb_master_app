import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';
import 'package:ybb_master_app/core/services/program_timeline_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/core/widgets/common_widgets.dart';
import 'package:ybb_master_app/core/widgets/loading_widget.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

import '../../../../core/services/program_payment_service.dart';

class AddEditProgramTimeline extends StatefulWidget {
  final ProgramTimelineModel? programTimeline;

  const AddEditProgramTimeline({super.key, this.programTimeline});

  @override
  State<AddEditProgramTimeline> createState() => _AddEditProgramTimelineState();
}

class _AddEditProgramTimelineState extends State<AddEditProgramTimeline> {
  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _descKey = GlobalKey<FormBuilderFieldState>();
  final _startDateKey = GlobalKey<FormBuilderFieldState>();
  final _endDateKey = GlobalKey<FormBuilderFieldState>();
  final _orderKey = GlobalKey<FormBuilderFieldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  String? timelineName, timelineDesc, timelineOrder;

  DateTime? timelineStartDate, timelineEndDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    setValue();
  }

  void setValue() {
    if (widget.programTimeline != null) {
      timelineName = widget.programTimeline!.name;
      timelineDesc = widget.programTimeline!.description;
      timelineStartDate = widget.programTimeline!.startDate;
      timelineEndDate = widget.programTimeline!.endDate;
      timelineOrder = widget.programTimeline!.orderNumber;
    }
  }

  save() async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        isLoading = true;
      });

      ProgramTimelineModel timeline = ProgramTimelineModel(
        programId: Provider.of<ProgramProvider>(context, listen: false)
            .currentProgram!
            .id,
        name: _nameKey.currentState!.value,
        description: _descKey.currentState!.value,
        startDate: _startDateKey.currentState!.value,
        endDate: _endDateKey.currentState!.value,
        orderNumber: _orderKey.currentState!.value,
      );

      if (widget.programTimeline != null) {
        timeline.id = widget.programTimeline!.id;

        await ProgramTimelineService().update(timeline).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Timeline updated successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .updateProgramTimeline(value);

          Navigator.pop(context);
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
        await ProgramTimelineService().add(timeline).then((value) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment added successfully'),
            ),
          );

          Provider.of<ProgramProvider>(context, listen: false)
              .addProgramTimeline(value);

          Navigator.pop(context);
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
          title: widget.programTimeline == null
              ? "Add Program Timeline"
              : "Edit Program Timeline"),
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
                  "Timeline Name",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ],
                  initial: timelineName ?? "",
                ),
                CommonWidgets().buildTextField(
                  _descKey,
                  "description",
                  "Timeline Description",
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(10),
                  ],
                  initial: timelineDesc ?? "",
                ),
                CommonWidgets().buildDateField(
                  _startDateKey,
                  "start_date",
                  "Start Date",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: timelineStartDate,
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
                  initial: timelineEndDate,
                ),
                CommonWidgets().buildTextField(
                  _orderKey,
                  "order_number",
                  "Order Number",
                  [
                    FormBuilderValidators.required(),
                  ],
                  initial: timelineOrder ?? "",
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
