import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';
import 'package:mopet/features/authentication/view_models/login_view_model.dart';
import 'package:mopet/features/authentication/views/widgets/social_button.dart';

class LoginScreen extends ConsumerWidget {
  static const routeName = "login";
  static const routeUrl = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MopetColor.light01.withOpacity(0.8),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              color: MopetColor.light01,
              child: Column(
                children: [
                  Gaps.v(32),
                  Row(
                    children: [
                      Text(
                        "login_screen_title",
                        style: MopetTextStyle.p70024,
                      ).tr(),
                      const Expanded(child: SizedBox()),
                      const ImageIcon(
                        AssetImage('assets/images/commonBtnX.png'),
                        size: 24,
                      ),
                    ],
                  ),
                  Gaps.v(24),
                  SocialButton(
                    socialButtonType: SocialButtonType.apple,
                    onTap: () => ref
                        .read(loginProvider.notifier)
                        .loginWithApple(context),
                  ),
                  Gaps.v(16),
                  SocialButton(
                    socialButtonType: SocialButtonType.google,
                    onTap: () => ref
                        .read(loginProvider.notifier)
                        .loginWithGoogle(context),
                  ),
                  Gaps.v(16),
                  SocialButton(
                    socialButtonType: SocialButtonType.kakao,
                    onTap: () => ref
                        .read(loginProvider.notifier)
                        .loginWithKakao(context),
                  ),
                  Gaps.v(32),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
