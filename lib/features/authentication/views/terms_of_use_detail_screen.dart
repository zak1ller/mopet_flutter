import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/view_models/terms_of_use_view_model.dart';
import 'package:mopet/utils/widget_manager.dart';

class TermsOfUseDetailScreen extends ConsumerStatefulWidget {
  final int termsId;

  const TermsOfUseDetailScreen({
    super.key,
    required this.termsId,
  });

  @override
  ConsumerState<TermsOfUseDetailScreen> createState() =>
      _TermsOfUseDetailScreenState();
}

class _TermsOfUseDetailScreenState
    extends ConsumerState<TermsOfUseDetailScreen> {
  final GlobalKey _backButtonKey = GlobalKey();

  Offset? _backButtonCenter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    setState(() {
      _backButtonCenter = WidgetManager.getCenter(_backButtonKey, context);
    });
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final terms = ref.watch(termsProvider(widget.termsId));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/commonBtnCheck.png",
                    key: _backButtonKey,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    color: MopetColor.light07,
                  ),
                  Gaps.v(16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            terms.value?.title ?? "",
                            style: MopetTextStyle.p70032.copyWith(
                              color: MopetColor.light07,
                            ),
                          ),
                          Gaps.v(19),
                          Text(
                            terms.value?.content ?? "",
                            style: MopetTextStyle.p30016.copyWith(
                              color: MopetColor.light07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left:
                  _backButtonCenter != null ? _backButtonCenter!.dx - 20 : null,
              top:
                  _backButtonCenter != null ? _backButtonCenter!.dy - 20 : null,
              child: GestureDetector(
                onTap: _onBackPressed,
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
