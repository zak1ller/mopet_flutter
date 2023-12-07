import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class BottomButton extends ConsumerStatefulWidget {
  final String text;
  final bool enable;
  final Function onTap;

  const BottomButton({
    super.key,
    required this.text,
    this.enable = true,
    required this.onTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BottomButtonState();
}

class BottomButtonState extends ConsumerState<BottomButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.enable) {
          widget.onTap();
        }
      },
      child: Column(
        children: [
          Container(
            height: 56,
            color: widget.enable ? MopetColor.light07 : MopetColor.light04,
            child: Center(
              child: Text(
                widget.text,
                style:
                    MopetTextStyle.p70020.copyWith(color: MopetColor.light01),
              ).tr(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: widget.enable ? MopetColor.light07 : MopetColor.light04,
          ),
        ],
      ),
    );
  }
}
