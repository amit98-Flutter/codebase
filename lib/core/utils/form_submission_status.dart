import 'package:flutter/cupertino.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

/// The form is in the initial state.
class InitialState extends FormSubmissionStatus {
  const InitialState();
}

class Loading2Status extends FormSubmissionStatus {
  const Loading2Status();
}

class SuccessStatus extends FormSubmissionStatus {
  final Widget? page;
  final Object? arguments;

  SuccessStatus({required this.page , this.arguments});
}

class SuccessStatus2 extends FormSubmissionStatus {}

class SuccessStatus3 extends FormSubmissionStatus {}

class SuccessStatus4 extends FormSubmissionStatus {
  final String? message;

  SuccessStatus4({required this.message});
}

class FailedStatus extends FormSubmissionStatus {
  final dynamic exception;

  FailedStatus({required this.exception});
}
