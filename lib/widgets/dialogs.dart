import 'package:flutter/material.dart';

import '../services/l10n_service.dart';
import 'widgets_l10n.dart';

class DialogAlert extends AlertDialog {
  static void show(BuildContext context, String content, {String title}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = L10nService.of<WidgetsL10n>(context);
        return AlertDialog(
          title: title == null ? null : Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(l10n.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class DialogConfirm extends AlertDialog {
  static void show(
    BuildContext context,
    String content,
    Function() onYes, {
    String title,
    String yes,
    String no,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = L10nService.of<WidgetsL10n>(context);
        return AlertDialog(
          title: title == null ? null : Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text(l10n.no),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(l10n.yes),
              onPressed: () {
                Navigator.of(context).pop();
                onYes();
              },
            ),
          ],
        );
      },
    );
  }
}
