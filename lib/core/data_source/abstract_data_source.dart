import 'package:flutter/material.dart';

class ParticipantAbstractDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    throw UnimplementedError();
  }

  @override
  bool get isRowCountApproximate => throw UnimplementedError();

  @override
  // TODO: implement rowCount
  int get rowCount => throw UnimplementedError();

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => throw UnimplementedError();
}
