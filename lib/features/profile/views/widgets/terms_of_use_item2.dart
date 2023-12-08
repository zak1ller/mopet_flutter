import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class TermsOfUseItem2 extends ConsumerWidget {
  final String title;
  final Function onTap;

  const TermsOfUseItem2({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          Text(
            title,
            style: MopetTextStyle.p50016.copyWith(color: MopetColor.light07),
          ).tr(),
          Expanded(
            child: Container(),
          ),
          Image.asset(
            "assets/images/btnBack.png",
            color: MopetColor.light04,
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
