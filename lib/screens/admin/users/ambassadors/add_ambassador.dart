import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/services/ambassador_service.dart';
import 'package:ybb_master_app/core/widgets/common_app_bar.dart';
import 'package:ybb_master_app/providers/ambassador_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class AddAmbassador extends StatefulWidget {
  const AddAmbassador({super.key});

  @override
  State<AddAmbassador> createState() => _AddAmbassadorState();
}

class _AddAmbassadorState extends State<AddAmbassador> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  saveData() async {
    // save data to the database
    Map<String, dynamic> data = {
      'email': emailController.text,
      'name': nameController.text,
      "program_id": Provider.of<ProgramProvider>(context, listen: false)
          .currentProgram!
          .id,
    };

    await AmbassadorService().add(data).then((value) {
      // show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ambassador added successfully'),
        ),
      );

      Provider.of<AmbassadorProvider>(context, listen: false)
          .addAmbassador(value);

      // clear the text fields
      emailController.clear();
      nameController.clear();

      // pop the screen
      Navigator.pop(context);
    }).catchError((e) {
      // show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CommonAppBar(title: "Add New Ambassador"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // add a decoration to the text field with a border and a label
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                hintText: 'Enter ambassador email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              // add a decoration to the text field with a border and a label
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'Enter ambassador name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                saveData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
