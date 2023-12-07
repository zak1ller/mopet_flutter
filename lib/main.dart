import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/firebase_options.dart';
import 'package:mopet/router.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

// 앱에서 지원하는 언어 리스트 변수
final supportedLocales = [
  const Locale('en', 'US'),
  const Locale('ko', 'KR'),
];

void main() async {
  // Flutter 엔진 및 위젯 초화
  WidgetsFlutterBinding.ensureInitialized();

  // easylocalization 초기화!
  await EasyLocalization.ensureInitialized();

  // 파이어베이스 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 카카오 SDK 초기화
  KakaoSdk.init(nativeAppKey: "f453a082b0e58b382b15d3826bcfe2e1");
  
  // 세로 화면 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Status bar 색상 고정
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 밝은 색 아이콘
  ));

  await SharedPreferencesManager.initialize();

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: MopetColor.light01,
      ),
    );
  }
}
