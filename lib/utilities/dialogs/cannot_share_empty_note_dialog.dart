import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> cannotShareEmptyNoteDialog(BuildContext context) async {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You Cannot Share Empty Note',
    optionsBuilder: () => {'OK': null},
  );
}
