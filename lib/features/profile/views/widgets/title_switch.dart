import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class TitleSwitch extends ConsumerWidget {
  final String title;
  final bool isOn;
  final Function(bool) onChanged;

  const TitleSwitch({
    super.key,
    required this.title,
    required this.isOn,
    required this.onChanged,
  });

  void _onChanged(bool value) {
    onChanged(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          title,
          style: MopetTextStyle.p50016.copyWith(color: MopetColor.light07),
        ).tr(),
        Expanded(
          child: Container(),
        ),
        Switch(
          value: isOn,
          onChanged: _onChanged,
        ),
      ],
    );
  }
}
