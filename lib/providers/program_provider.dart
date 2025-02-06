import 'package:flutter/material.dart';
import 'package:ybb_master_app/core/models/document_batch_model.dart';
import 'package:ybb_master_app/core/models/payment_method_model.dart';
import 'package:ybb_master_app/core/models/program/program_model.dart';
import 'package:ybb_master_app/core/models/program/program_category_model.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/models/program_info_by_url_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';

class ProgramProvider extends ChangeNotifier {
  ProgramModel? _currentProgram;
  ProgramInfoByUrlModel? _currentProgramInfo;
  List<ProgramModel> _programs = [];
  List<ProgramCategoryModel> _programCategories = [];
  List<ProgramPaymentModel>? _programPayments;
  List<PaymentMethodModel>? _paymentMethods;
  List<ProgramTimelineModel>? _programTimelines;
  List<ProgramDocumentModel>? _programDocuments;
  List<ProgramCertificateModel>? _programCertificates;
  List<DocumentBatchModel>? _documentBatches;

  ProgramInfoByUrlModel? get currentProgramInfo => _currentProgramInfo;

  set currentProgramInfo(ProgramInfoByUrlModel? currentProgramInfo) {
    _currentProgramInfo = currentProgramInfo;
    notifyListeners();
  }

  void updateCurrentProgramInfo(ProgramInfoByUrlModel programInfo) {
    _currentProgramInfo = programInfo;
    notifyListeners();
  }

  void removeCurrentProgramInfo() {
    _currentProgramInfo = null;
    notifyListeners();
  }

  List<DocumentBatchModel>? get documentBatches => _documentBatches;

  set documentBatches(List<DocumentBatchModel>? documentBatches) {
    _documentBatches = documentBatches;
    notifyListeners();
  }

  addDocumentBatch(DocumentBatchModel documentBatch) {
    _documentBatches!.add(documentBatch);
    notifyListeners();
  }

  removeDocumentBatch(DocumentBatchModel documentBatch) {
    _documentBatches!.remove(documentBatch);
    notifyListeners();
  }

  updateDocumentBatch(DocumentBatchModel documentBatch) {
    int index = _documentBatches!
        .indexWhere((element) => element.id == documentBatch.id);
    _documentBatches![index] = documentBatch;
    notifyListeners();
  }

  List<ProgramCertificateModel>? get programCertificates =>
      _programCertificates;

  set programCertificates(List<ProgramCertificateModel>? programCertificates) {
    _programCertificates = programCertificates;
    notifyListeners();
  }

  addProgramCertificate(ProgramCertificateModel programCertificate) {
    _programCertificates!.add(programCertificate);
    notifyListeners();
  }

  removeProgramCertificate(ProgramCertificateModel programCertificate) {
    _programCertificates!.remove(programCertificate);
    notifyListeners();
  }

  updateProgramCertificate(ProgramCertificateModel programCertificate) {
    int index = _programCertificates!
        .indexWhere((element) => element.id == programCertificate.id);
    _programCertificates![index] = programCertificate;
    notifyListeners();
  }

  List<ProgramDocumentModel>? get programDocuments => _programDocuments;

  set programDocuments(List<ProgramDocumentModel>? programDocuments) {
    _programDocuments = programDocuments;
    notifyListeners();
  }

  addProgramDocument(ProgramDocumentModel programDocument) {
    _programDocuments!.add(programDocument);
    notifyListeners();
  }

  removeProgramDocument(ProgramDocumentModel programDocument) {
    _programDocuments!.remove(programDocument);
    notifyListeners();
  }

  updateProgramDocument(ProgramDocumentModel programDocument) {
    int index = _programDocuments!
        .indexWhere((element) => element.id == programDocument.id);
    _programDocuments![index] = programDocument;
    notifyListeners();
  }

  List<ProgramTimelineModel>? get programTimelines => _programTimelines;

  set programTimelines(List<ProgramTimelineModel>? programTimelines) {
    _programTimelines = programTimelines;
    notifyListeners();
  }

  addProgramTimeline(ProgramTimelineModel programTimeline) {
    _programTimelines!.add(programTimeline);
    notifyListeners();
  }

  removeProgramTimeline(ProgramTimelineModel programTimeline) {
    _programTimelines!.remove(programTimeline);
    notifyListeners();
  }

  updateProgramTimeline(ProgramTimelineModel programTimeline) {
    int index = _programTimelines!
        .indexWhere((element) => element.id == programTimeline.id);

    _programTimelines![index] = programTimeline;
    notifyListeners();
  }

  List<PaymentMethodModel>? get paymentMethods => _paymentMethods;

  set paymentMethods(List<PaymentMethodModel>? paymentMethods) {
    _paymentMethods = paymentMethods;
    notifyListeners();
  }

  addPaymentMethod(PaymentMethodModel paymentMethod) {
    _paymentMethods!.add(paymentMethod);
    notifyListeners();
  }

  removePaymentMethod(PaymentMethodModel paymentMethod) {
    _paymentMethods!.remove(paymentMethod);
    notifyListeners();
  }

  updatePaymentMethod(PaymentMethodModel paymentMethod) {
    int index = _paymentMethods!
        .indexWhere((element) => element.id == paymentMethod.id);
    _paymentMethods![index] = paymentMethod;
    notifyListeners();
  }

  List<ProgramPaymentModel>? get programPayments => _programPayments;

  set programPayments(List<ProgramPaymentModel>? programPayments) {
    _programPayments = programPayments;
    notifyListeners();
  }

  addProgramPayment(ProgramPaymentModel programPayment) {
    _programPayments!.add(programPayment);
    notifyListeners();
  }

  removeProgramPayment(ProgramPaymentModel programPayment) {
    _programPayments!.remove(programPayment);
    notifyListeners();
  }

  updateProgramPayment(ProgramPaymentModel programPayment) {
    int index = _programPayments!
        .indexWhere((element) => element.id == programPayment.id);
    _programPayments![index] = programPayment;
    notifyListeners();
  }

  List<ProgramCategoryModel> get programCategories => _programCategories;

  set programCategories(List<ProgramCategoryModel> programCategories) {
    _programCategories = programCategories;
    notifyListeners();
  }

  ProgramModel? get currentProgram => _currentProgram;

  set currentProgram(ProgramModel? currentProgram) {
    _currentProgram = currentProgram;
    notifyListeners();
  }

  void updateProgram(ProgramModel program) {
    _currentProgram = program;
    notifyListeners();
  }

  void removeCurrentProgram() {
    _currentProgram = null;
    notifyListeners();
  }

  List<ProgramModel> get programs => _programs;

  set programs(List<ProgramModel> programs) {
    _programs = programs;
    notifyListeners();
  }

  void addProgram(ProgramModel program) {
    _programs.add(program);
    notifyListeners();
  }

  void removeProgram(ProgramModel program) {
    _programs.remove(program);
    notifyListeners();
  }
}
