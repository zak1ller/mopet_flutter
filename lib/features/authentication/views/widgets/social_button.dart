import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

enum SocialButtonType {
  apple,
  google,
  kakao,
}

class SocialButton extends ConsumerWidget {
  final SocialButtonType socialButtonType;
  final Function onTap;

  const SocialButton({
    super.key,
    required this.socialButtonType,
    required this.onTap,
  });

  Color _getBackgroundColor() {
    switch (socialButtonType) {
      case SocialButtonType.apple:
        return MopetColor.light07;
      case SocialButtonType.google:
        return MopetColor.light03;
      case SocialButtonType.kakao:
        return MopetColor.kakao;
      default:
        return MopetColor.light07;
    }
  }

  Image _getAssetImage() {
    var asset = "";

    switch (socialButtonType) {
      case SocialButtonType.apple:
        asset = 'assets/images/commonIconApple.png';
        break;
      case SocialButtonType.google:
        asset = 'assets/images/commonIconGoogle.png';
        break;
      case SocialButtonType.kakao:
        asset = 'assets/images/commonIconKakao.png';
        break;
      default:
        asset = 'assets/images/commonIconApple.png';
        break;
    }

    return Image.asset(
      asset,
      width: 24,
      height: 24,
    );
  }

  String _getTitle() {
    switch (socialButtonType) {
      case SocialButtonType.apple:
        return 'social_login_apple';
      case SocialButtonType.google:
        return 'social_login_google';
      case SocialButtonType.kakao:
        return 'social_login_kakao';
      default:
        return 'social_login_apple';
    }
  }

  Color _getTitleColor() {
    switch (socialButtonType) {
      case SocialButtonType.apple:
        return MopetColor.light01;
      case SocialButtonType.google:
        return MopetColor.light07;
      case SocialButtonType.kakao:
        return MopetColor.light07;
      default:
        return MopetColor.light01;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        color: _getBackgroundColor(),
        height: 48,
        child: Row(
          children: [
            Gaps.h(16),
            _getAssetImage(),
            const Expanded(child: SizedBox()),
            Text(
              _getTitle(),
              style: MopetTextStyle.p50016.copyWith(
                color: _getTitleColor(),
              ),
            ).tr(),
            Gaps.h(16),
          ],
        ),
      ),
    );
  }
}
