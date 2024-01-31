import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/models/program.dart';

class ProgramTile extends StatelessWidget {
  final Program program;
  const ProgramTile({required this.program, super.key});

  _getStatusChip() {
    return Chip(
      label: Text(program.isActive! ? "Active" : "Inactive"),
      backgroundColor: program.isActive! ? Colors.green : Colors.red,
      labelStyle: const TextStyle(color: Colors.white),
      side: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/dashboard');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                program.image!,
                width: 100,
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
                          Text(program.name!,
                              style:
                                  Theme.of(context).textTheme.headlineSmall!),
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
