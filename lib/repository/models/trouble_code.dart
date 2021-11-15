import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kTroubleCode = 'TroubleCodes';

class TroubleCode extends ParseObject implements ParseCloneable {
  TroubleCode() : super(kTroubleCode);
  TroubleCode.clone() : this();

  @override
  TroubleCode clone(Map<String, dynamic> map) =>
      TroubleCode.clone()..fromJson(map);

  String? get potentialSymptoms {
    return this.get('PotentialSymptoms');
  }

  set potentialSymptoms(String? value) {
    set('PotentialSymptoms', value);
  }

  String? get meaningText {
    return get('MeaningText');
  }

  set meaningText(String? value) {
    set('MeaningText', value);
  }

  String? get causes {
    return get('Causes');
  }

  set causes(String? value) {
    set('Causes', value);
  }

  String? get code {
    return get('Code');
  }

  set code(String? value) {
    set('Code', value);
  }

  ParseFile? get possibleSolutionsImage {
    return get('PossibleSolutionsImage');
  }

  set possibleSolutionsImage(ParseFile? value) {
    set('PossibleSolutionsImage', value);
  }

  String? get possibleSolutionsText {
    return get('PossibleSolutionsText');
  }

  set possibleSolutionsText(String? value) {
    set('PossibleSolutionsText', value);
  }

  String? get diagnosticsAndRepair {
    return get('diagnosticsAndRepair');
  }

  set diagnosticsAndRepair(String? value) {
    set('diagnosticsAndRepair', value);
  }

  String? get description {
    return get('Description');
  }

  set description(String? value) {
    set('Description', value);
  }

  ParseFile? get meaningImage {
    return get('MeaningImage');
  }

  set meaningImage(ParseFile? value) {
    set('MeaningImage', value);
  }
  

}
