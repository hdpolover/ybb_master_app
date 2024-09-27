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

  static exportParticipantData(
      List<ParticipantModel> participants, String category) {
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
      cellValues.add(TextCellValue(participant.fullName ?? "-"));
      cellValues.add(TextCellValue(participant.email ?? "-"));
      cellValues.add(TextCellValue(participant.phoneNumber ?? "-"));
      cellValues.add(TextCellValue(participant.gender ?? "-"));
      cellValues.add(TextCellValue(participant.birthdate != null
          ? CommonMethods.formatDate(participant.birthdate)
          : "-"));
      cellValues.add(TextCellValue(participant.originAddress ?? "-"));
      cellValues.add(TextCellValue(participant.currentAddress ?? "-"));
      cellValues.add(TextCellValue(participant.nationality ?? "-"));
      cellValues.add(TextCellValue(participant.tshirtSize ?? "-"));
      cellValues.add(TextCellValue(participant.occupation ?? "-"));
      cellValues.add(TextCellValue(participant.institution ?? "-"));
      cellValues.add(TextCellValue(participant.organizations ?? "-"));
      cellValues.add(TextCellValue(participant.instagramAccount ?? "-"));
      cellValues.add(TextCellValue(participant.emergencyAccount ?? "-"));
      cellValues.add(TextCellValue(participant.contactRelation ?? "-"));
      cellValues.add(TextCellValue(participant.diseaseHistory ?? "-"));
      cellValues.add(TextCellValue(participant.experiences ?? "-"));
      cellValues.add(TextCellValue(participant.achievements ?? "-"));

      sheet.appendRow(cellValues);

      index++;
    }

    DateTime now = DateTime.now();
    String formatDate = "(${now.day}/${now.month}/${now.year})";

    var fileName = getExcelFileName('$formatDate $category Participant Data');

    var fileBytes = excel.save(fileName: fileName);
  }
}
