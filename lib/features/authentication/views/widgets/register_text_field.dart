import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class RegisterTextField extends ConsumerStatefulWidget {
  final String title;
  final String placeholder;
  final bool showWarningTextField;
  final Function(String) onValueChanged;
  final FocusNode? focusNode;
  final TextInputType textInputType;

  const RegisterTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.showWarningTextField,
    required this.onValueChanged,
    this.focusNode,
    this.textInputType = TextInputType.text
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterTextFieldState();
}

class _RegisterTextFieldState extends ConsumerState<RegisterTextField> {
  final TextEditingController _editingController = TextEditingController();

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
                  keyboardType: widget.textInputType,
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
          ],
        ),
      ],
    );
  }
}
