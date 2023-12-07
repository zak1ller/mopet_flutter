import 'package:flutter/material.dart';

class WidgetManager {
  static Offset getCenter(GlobalKey key, BuildContext context) {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero); // 위젯의 왼쪽 상단 모서리 위치
    final size = renderBox.size; // 위젯의 크기

    // SafeArea 여백 계산
    final safeAreaPadding = MediaQuery.of(context).padding;
    final safeAreaOffset = Offset(safeAreaPadding.left, safeAreaPadding.top);

    // 중심 좌표 계산
    return position + Offset(size.width / 2, size.height / 2) - safeAreaOffset;
  }
}
