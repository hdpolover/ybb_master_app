import 'package:excel/excel.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/widgets/common_methods.dart';

class ExcelHelper {
  static const String _excelExtension = '.xlsx';

  static String getExcelFileName(String fileName) {
    return fileName + _excelExtension;
  }

  static String getExcelSheetName(String sheetName) {
    return sheetName;
  }

  static exportPaymentData(List<FullPaymentModel> payments, String filter) {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    CellStyle cellStyle =
        CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    List<String> headers = [
      'No.',
      'Full Name',
      'Email',
      'Gender',
      'Phone Number',
      'Nationality',
      'Institution',
      'Program Payment Name',
      'Payment Method Name',
      'Payment Type',
      'Proof Url',
      'Payment Date',
    ];
    List<TextCellValue> cellValues = [];

    for (var header in headers) {
      cellValues.add(TextCellValue(header));
    }

    sheet.appendRow(cellValues);

    int index = 1;

    for (var payment in payments) {
      List<TextCellValue> cellValues = [];

      cellValues.add(TextCellValue(index.toString()));
      cellValues.add(TextCellValue(payment.fullName ?? "-"));
      cellValues.add(TextCellValue(payment.email ?? "-"));
      cellValues.add(TextCellValue(payment.gender ?? "-"));
      cellValues.add(TextCellValue(payment.phoneNumber ?? "-"));
      cellValues.add(TextCellValue(payment.nationality ?? "-"));
      cellValues.add(TextCellValue(payment.institution ?? "-"));
      cellValues.add(TextCellValue(payment.programPaymentsName ?? "-"));
      cellValues.add(TextCellValue(payment.paymentMethodsName ?? "-"));
      cellValues.add(TextCellValue(payment.type ?? "-"));
      cellValues.add(TextCellValue(payment.proofUrl ?? "-"));
      cellValues.add(TextCellValue(payment.createdAt != null
          ? CommonMethods.formatDateWithTime(payment.createdAt)
          : "-"));

      sheet.appendRow(cellValues);

      index++;
    }

    DateTime now = DateTime.now();
    String formatDate = "(${now.day}/${now.month}/${now.year})";

    var fileName =
        getExcelFileName('$formatDate $filter | Participant Payment Data');

    var fileBytes = excel.save(fileName: fileName);
  }

  String getDisplayValue(dynamic value, {String placeholder = "-"}) {
    if (value == null || value.toString().isEmpty) {
      return placeholder;
    }

    // if value is a date time
    if (value is DateTime) {
      return CommonMethods.formatDate(value);
    }

    return value.toString();
  }

  Future<bool> exportParticipantData(
      List<ParticipantModel> participants, String category) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    CellStyle cellStyle =
        CellStyle(fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    List<String> headers = [
      'No.',
      'Full Name',
      'Email',
      'Phone Number',
      'Gender',
      'Birth Date',
      'Origin Address',
      'Current Address',
      'Nationality',
      'Tshirt Size',
      'Occupation',
      'Institution',
      'Organization',
      'Instagram Account',
      'Emergency Contact',
      'Emergency Contact Relation',
      'Disease History',
      'Experiences',
      'Achievements',
    ];
    List<TextCellValue> cellValues = [];

    for (var header in headers) {
      cellValues.add(TextCellValue(header));
    }

    sheet.appendRow(cellValues);

    int index = 1;

    for (var participant in participants) {
      List<TextCellValue> cellValues = [];

      cellValues.add(TextCellValue(index.toString()));

      // check which data is null
      cellValues.add(TextCellValue(getDisplayValue(participant.fullName)));
      cellValues.add(TextCellValue(getDisplayValue(participant.email)));
      cellValues.add(TextCellValue(getDisplayValue(participant.phoneNumber)));
      cellValues.add(TextCellValue(getDisplayValue(participant.gender)));
      cellValues.add(TextCellValue(getDisplayValue(participant.birthdate)));
      cellValues.add(TextCellValue(getDisplayValue(participant.originAddress)));
      cellValues
          .add(TextCellValue(getDisplayValue(participant.currentAddress)));
      cellValues.add(TextCellValue(getDisplayValue(participant.nationality)));
      cellValues.add(TextCellValue(getDisplayValue(participant.tshirtSize)));
      cellValues.add(TextCellValue(getDisplayValue(participant.occupation)));
      cellValues.add(TextCellValue(getDisplayValue(participant.institution)));
      cellValues.add(TextCellValue(getDisplayValue(participant.organizations)));
      cellValues
          .add(TextCellValue(getDisplayValue(participant.instagramAccount)));
      cellValues
          .add(TextCellValue(getDisplayValue(participant.emergencyAccount)));
      cellValues
          .add(TextCellValue(getDisplayValue(participant.contactRelation)));
      cellValues
          .add(TextCellValue(getDisplayValue(participant.diseaseHistory)));
      cellValues.add(TextCellValue(getDisplayValue(participant.experiences)));
      cellValues.add(TextCellValue(getDisplayValue(participant.achievements)));

      sheet.appendRow(cellValues);

      index++;
    }

    List<int>? fileBytes;

    // make sure loop is done by now
    if (index == participants.length + 1) {
      DateTime now = DateTime.now();
      String formatDate = "(${now.day}/${now.month}/${now.year})";

      var fileName = getExcelFileName('$formatDate $category Participant Data');

      fileBytes = excel.save(fileName: fileName);
    }

    if (fileBytes != null) {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }
}
