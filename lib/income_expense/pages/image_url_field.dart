
import 'package:flutter/cupertino.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ImageUrlField extends StatelessWidget {
  final String? initialValue;
  const ImageUrlField({super.key, required this.initialValue, });

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return ShadInputFormField(
      id: 'image_url',
      initialValue: initialValue,
      label: Text(appLocalization.imageLink),
      placeholder: Text(appLocalization.addLinkImage),
      leading: Icon(LucideIcons.image),
    );
  }

}