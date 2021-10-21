import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kPermission = 'Permission';

class Permission extends ParseObject implements ParseCloneable {
  Permission() : super(kPermission);
  Permission.clone() : this();

  @override
  Permission clone(Map<String, dynamic> map) =>
      Permission.clone()..fromJson(map);

  String? get name {
    return this.get('Name');
  }

  set name(String? value) {
    set('Name', value);
  }

  String? get description {
    return get('Description');
  }

  set description(String? value) {
    set('Description', value);
  }
}
