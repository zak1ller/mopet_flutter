import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/common/widgets/bottom_button.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/views/terms_of_use_screen.dart';
import 'package:mopet/features/authentication/views/widgets/service_access_permission_iitem.dart';
import 'package:mopet/utils/widget_manager.dart';

class ServiceAccessPermissionScreen extends ConsumerStatefulWidget {
  static const routeName = "service_access_permission";
  static const routeUrl = "service_access_permission";

  final String provider;
  final String accessToekn;

  const ServiceAccessPermissionScreen({
    super.key,
    required this.provider,
    required this.accessToekn,
  });

  @override
  ConsumerState<ServiceAccessPermissionScreen> createState() =>
      _ServiceAccessPermissionScreenState();
}

class _ServiceAccessPermissionScreenState
    extends ConsumerState<ServiceAccessPermissionScreen> {
  final GlobalKey _backButtonKey = GlobalKey();
  final GlobalKey<BottomButtonState> _bottomButtonKey = GlobalKey();

  Offset? _backButtonCenter;

  @override
  void initState() {
    super.initState();
    // 중심 좌표 계산을 위한 지연 처리
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _onBackPressed() {
    context.pop();
  }

  void _onNextPressed() {
    context.pushNamed(
      TermsOfUseScreen.routeName,
      extra: {
        "provider": widget.provider,
        "accessToken": widget.accessToekn,
      },
    );
  }

  _afterLayout(_) {
    setState(() {
      _backButtonCenter = WidgetManager.getCenter(_backButtonKey, context);
    });
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
                        "service_access_permission_title",
                        style: MopetTextStyle.p70032.copyWith(
                          color: MopetColor.light07,
                        ),
                      ).tr(),
                      Gaps.v(27),
                      const ServiceAccessPermissionItem(
                        imageAsset: "assets/images/commonIconGps.png",
                        title: "service_access_permission_item_location_title",
                        description:
                            "service_access_permission_item_location_description",
                      ),
                      Gaps.v(24),
                      const ServiceAccessPermissionItem(
                        imageAsset: "assets/images/commonIconCam.png",
                        title: "service_access_permission_item_camera_title",
                        description:
                            "service_access_permission_item_camera_description",
                      ),
                      Gaps.v(24),
                      const ServiceAccessPermissionItem(
                        imageAsset: "assets/images/commonIconPic.png",
                        title: "service_access_permission_item_storage_title",
                        description:
                            "service_access_permission_item_storage_description",
                      ),
                      Gaps.v(24),
                      const ServiceAccessPermissionItem(
                        imageAsset: "assets/images/commonIconAlert.png",
                        title:
                            "service_access_permission_item_notification_title",
                        description:
                            "service_access_permission_item_notification_description",
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
              key: _bottomButtonKey,
              text: "next_button",
              onTap: _onNextPressed,
            ),
          ),
        ],
      ),
    );
  }
}
