import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class ProgramTile extends StatelessWidget {
  final ProgramModel program;
  const ProgramTile({required this.program, super.key});

  _getStatusChip() {
    return Chip(
      label: Text(program.isActive == "1" ? "Active" : "Inactive"),
      backgroundColor: program.isActive == "1" ? Colors.green : Colors.red,
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProgramProvider>(context, listen: false).currentProgram =
            program;

        context.push('/dashboard');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  program.logoUrl ?? "",
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(program.name!,
                                softWrap: true,
                                style:
                                    Theme.of(context).textTheme.headlineSmall!),
                          ),
                          _getStatusChip(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(program.description!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
