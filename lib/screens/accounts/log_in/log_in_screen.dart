import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../services/l10n_service.dart';
import 'log_in_form.dart';
import 'log_in_l10n.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogInL10n l10n = L10nService.of<LogInL10n>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: LogInForm(),
      ),
    );
  }
}
