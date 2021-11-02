import 'dart:io';

import 'package:formz/formz.dart';

enum OptionalFileValidationError { empty }

class OptionalFile extends FormzInput<File?, OptionalFileValidationError> {
  const OptionalFile.pure() : super.pure(null);
  const OptionalFile.dirty([File? value]) : super.dirty(value);

  @override
  OptionalFileValidationError? validator(File? value) {
    return null;
  }
}
