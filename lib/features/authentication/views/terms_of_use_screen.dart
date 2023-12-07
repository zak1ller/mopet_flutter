import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/common/widgets/bottom_button.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/views/number_auth_screen.dart';
import 'package:mopet/features/authentication/views/terms_of_use_detail_screen.dart';
import 'package:mopet/features/authentication/views/widgets/terms_of_use_item.dart';
import 'package:mopet/utils/widget_manager.dart';

class TermsOfUseScreen extends ConsumerStatefulWidget {
  static const routeName = "terms_of_use";
  static const routeUrl = "terms_of_use";

  final String provider;
  final String accessToken;

  const TermsOfUseScreen({
    super.key,
    required this.provider,
    required this.accessToken,
  });

  @override
  ConsumerState<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends ConsumerState<TermsOfUseScreen> {
  final GlobalKey _backButtonKey = GlobalKey();

  Offset? _backButtonCenter;

  bool _allowAge = false;
  bool _allowAgree = false;
  bool _allowPersonalData = false;
  bool _allowLocation = false;
  bool _allowMarketing = false;

  @override
  void initState() {
    super.initState();
    // 중심 좌표 계산을 위한 지연 처리
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  _afterLayout(_) {
    setState(() {
      _backButtonCenter = WidgetManager.getCenter(_backButtonKey, context);
    });
  }

  void _onBackPressed() {
    context.pop();
  }

  void _onNextPressed() {
    context.pushNamed(
      NumberAuthScreen.routeName,
      extra: {
        "isMarketing": _allowMarketing,
        "provider": widget.provider,
        "accessToken": widget.accessToken,
      },
    );
  }

  void _onDetailPage(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsOfUseDetailScreen(termsId: id),
      ),
    );
  }

  void _onChangedAllowAgeValue(bool value) {
    setState(() {
      _allowAge = value;
    });
  }

  void _onChangedAllowAgreeValue(bool value) {
    setState(() {
      _allowAgree = value;
    });
  }

  void _onChangedAllowPersonalDataValue(bool value) {
    setState(() {
      _allowPersonalData = value;
    });
  }

  void _onChangedAllowLocationValue(bool value) {
    setState(() {
      _allowLocation = value;
    });
  }

  void _onChangedAllowMarketingValue(bool value) {
    setState(() {
      _allowMarketing = value;
    });
  }

  void _onAllCheckPressed(bool value) {
    if (value) {
      _allowAge = true;
      _allowAgree = true;
      _allowPersonalData = true;
      _allowLocation = true;
      _allowMarketing = true;
    } else {
      _allowAge = false;
      _allowAgree = false;
      _allowPersonalData = false;
      _allowLocation = false;
      _allowMarketing = false;
    }
    setState(() {});
  }

  bool isAllChecked() {
    if (_allowAge &&
        _allowAgree &&
        _allowPersonalData &&
        _allowLocation &&
        _allowMarketing) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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
                      Text(
                        "terms_of_use_title",
                        style: MopetTextStyle.p70032.copyWith(
                          color: MopetColor.light07,
                        ),
                      ).tr(),
                      Gaps.v(27),
                      TermsOfUseItem(
                        text: "terms_of_use_item_age",
                        checked: _allowAge,
                        onDetailPressed: () {},
                        onCheckedChanged: (value) =>
                            _onChangedAllowAgeValue(value),
                      ),
                      Gaps.v(16),
                      TermsOfUseItem(
                        text: "terms_of_use_item_agree",
                        checked: _allowAgree,
                        onDetailPressed: () => _onDetailPage(1),
                        onCheckedChanged: (value) =>
                            _onChangedAllowAgreeValue(value),
                      ),
                      Gaps.v(16),
                      TermsOfUseItem(
                        text: "terms_of_use_item_personal_data",
                        checked: _allowPersonalData,
                        onDetailPressed: () => _onDetailPage(2),
                        onCheckedChanged: (value) =>
                            _onChangedAllowPersonalDataValue(value),
                      ),
                      Gaps.v(16),
                      TermsOfUseItem(
                        text: "terms_of_use_item_location",
                        checked: _allowLocation,
                        onDetailPressed: () => _onDetailPage(3),
                        onCheckedChanged: (value) =>
                            _onChangedAllowLocationValue(value),
                      ),
                      Gaps.v(16),
                      TermsOfUseItem(
                        text: "terms_of_use_item_marketing",
                        checked: _allowMarketing,
                        onDetailPressed: () => _onDetailPage(4),
                        onCheckedChanged: (value) =>
                            _onChangedAllowMarketingValue(value),
                      ),
                      Gaps.v(32),
                      TermsOfUseItem(
                        text: "terms_of_use_item_all_agree",
                        isAllAgreeItem: true,
                        checked: isAllChecked(),
                        onDetailPressed: () {},
                        onCheckedChanged: (value) => _onAllCheckPressed(value),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: _backButtonCenter != null
                      ? _backButtonCenter!.dx - 20
                      : null,
                  top: _backButtonCenter != null
                      ? _backButtonCenter!.dy - 20
                      : null,
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomButton(
              enable: isAllChecked(),
              text: "next_button",
              onTap: _onNextPressed,
            ),
          ),
        ],
      ),
    );
  }
}
