import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class TermsOfUseItem extends ConsumerWidget {
  final String text;
  final bool checked;
  final bool isAllAgreeItem;
  final Function(bool) onCheckedChanged;
  final Function onDetailPressed;

  const TermsOfUseItem({
    super.key,
    required this.text,
    required this.checked,
    this.isAllAgreeItem = false,
    required this.onCheckedChanged,
    required this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onCheckedChanged(!checked),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            color: checked ? MopetColor.light07 : MopetColor.light04,
            child: Center(
              child: Image.asset(
                "assets/images/commonIconOk.png",
                fit: BoxFit.cover,
                width: 24,
                height: 24,
                color: MopetColor.light01,
              ),
            ),
          ),
          Gaps.h(16),
          Expanded(
            child: GestureDetector(
              onTap: () => onDetailPressed(),
              child: Text(
                text,
                style: isAllAgreeItem
                    ? MopetTextStyle.p70016.copyWith(color: MopetColor.light06)
                    : MopetTextStyle.p50016.copyWith(color: MopetColor.light06),
              ).tr(),
            ),
          ),
        ],
      ),
    );
  }
}
