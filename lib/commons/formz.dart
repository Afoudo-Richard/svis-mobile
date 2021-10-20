import 'package:formz/formz.dart';

export 'package:formz/formz.dart';

enum FormzSubmissionStatus { pure, inProgress, success, failure }

class FormzSubmission<E, F> {
  const FormzSubmission._(this.status, {this.error, this.success});

  const FormzSubmission.pure() : this._(FormzSubmissionStatus.pure);

  const FormzSubmission.inProgress() : this._(FormzSubmissionStatus.inProgress);

  const FormzSubmission.success({F? success})
      : this._(FormzSubmissionStatus.success, success: success);

  const FormzSubmission.failure(E error)
      : this._(FormzSubmissionStatus.failure, error: error);

  final E? error;
  final F? success;
  final FormzSubmissionStatus status;
}

mixin FormzMixin<E, F> {
  FormzStatus get status {
    switch (submission.status) {
      case FormzSubmissionStatus.inProgress:
        return FormzStatus.submissionInProgress;
      case FormzSubmissionStatus.success:
        return FormzStatus.submissionSuccess;
      case FormzSubmissionStatus.failure:
        return FormzStatus.submissionFailure;
      case FormzSubmissionStatus.pure:
        return Formz.validate(inputs);
    }
  }

  List<FormzInput> get inputs;

  FormzSubmission<E, F> get submission;
}
