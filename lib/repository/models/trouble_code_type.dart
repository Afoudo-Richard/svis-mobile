import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kTroubleCodeType = 'TroubleCodeType';

class TroubleCodeType extends ParseObject
    with EquatableMixin
    implements ParseCloneable {
  TroubleCodeType() : super(kTroubleCodeType);
  TroubleCodeType.clone() : this();

  @override
  TroubleCodeType clone(Map<String, dynamic> map) =>
      TroubleCodeType.clone()..fromJson(map);

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

    String? get description => get<String?>('Description');
  set description(String? value) => set<String?>('Description', value);

  @override
  List<Object?> get props => [
        objectId,
      ];
}
