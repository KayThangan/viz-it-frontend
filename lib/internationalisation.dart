import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BBIntl {
  BBIntl();

  final String localeName = 'en';

  static BBIntl of(BuildContext context) {
    // return Localizations.of(context, BBIntl);
    return BBIntl();
  }

  String get exampleString {
    return Intl.message('Example',
        name: 'exampleString', desc: 'Example string', locale: localeName);
  }
}
