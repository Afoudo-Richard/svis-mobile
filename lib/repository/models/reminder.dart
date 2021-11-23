import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String kReminderCode = 'Reminder';

class Reminder extends ParseObject implements ParseCloneable {
  Reminder() : super(kReminderCode);
  Reminder.clone() : this();

  @override
  Reminder clone(Map<String, dynamic> map) =>
      Reminder.clone()..fromJson(map);

  String? get name {
    return this.get('name');
  }

  set name(String? value) {
    set('name', value);
  }
 

}
