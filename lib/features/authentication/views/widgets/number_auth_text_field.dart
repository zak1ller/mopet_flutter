import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class NumberAuthTextField extends ConsumerStatefulWidget {
  final String title;
  final String placeholder;
  final String actionText;
  final bool showWarningTextField;
  final bool enableActionButton;
  final Function(String) onActionButtonTap;
  final Function(String) onValueChanged;
  final FocusNode? focusNode;

  const NumberAuthTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.actionText,
    required this.showWarningTextField,
    required this.enableActionButton,
    required this.onActionButtonTap,
    required this.onValueChanged,
    this.focusNode,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NumberAuthTextFieldState();
}

class _NumberAuthTextFieldState extends ConsumerState<NumberAuthTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _editingController.addListener(() {
      widget.onValueChanged(_editingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: MopetTextStyle.p50016.copyWith(color: MopetColor.light07),
        ).tr(),
        Gaps.v(8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: _editingController,
                  minLines: 1,
                  maxLines: 1,
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.number,
                  style:
                      MopetTextStyle.p70016.copyWith(color: MopetColor.light07),
                  decoration: InputDecoration(
                    hintText: widget.placeholder.tr(),
                    hintStyle: MopetTextStyle.p70016
                        .copyWith(color: MopetColor.light04),
                    fillColor: MopetColor.light02,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        width: 1,
                        color: widget.showWarningTextField
                            ? MopetColor.warning
                            : MopetColor.light07,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        width: 1,
                        color: widget.showWarningTextField
                            ? MopetColor.warning
                            : MopetColor.light07,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        width: 1,
                        color: widget.showWarningTextField
                            ? MopetColor.warning
                            : MopetColor.light07,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        width: 1,
                        color: widget.showWarningTextField
                            ? MopetColor.warning
                            : MopetColor.light07,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h(8),
            GestureDetector(
              onTap: () {
                if (widget.enableActionButton) {
                  widget.onActionButtonTap(_editingController.text);
                }
              },
              child: Container(
                width: 88,
                height: 48,
                color: widget.enableActionButton
                    ? MopetColor.light07
                    : MopetColor.light04,
                child: Center(
                  child: Text(
                    widget.actionText,
                    style: MopetTextStyle.p70016.copyWith(
                      color: MopetColor.light01,
                    ),
                  ).tr(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
