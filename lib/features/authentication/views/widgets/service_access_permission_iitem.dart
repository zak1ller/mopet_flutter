import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mopet/constants/gaps.dart';
import 'package:mopet/constants/mopet_color.dart';
import 'package:mopet/constants/mopet_text_style.dart';

class ServiceAccessPermissionItem extends ConsumerWidget {
  final String imageAsset;
  final String title;
  final String description;

  const ServiceAccessPermissionItem({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          color: MopetColor.light02,
          width: 48,
          height: 48,
          child: Center(
            child: Image.asset(
              imageAsset,
              width: 24,
              height: 24,
            ),
          ),
        ),
        Gaps.h(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    MopetTextStyle.p70016.copyWith(color: MopetColor.light07),
              ).tr(),
              Gaps.v(3),
              Text(
                description,
                style:
                    MopetTextStyle.p50014.copyWith(color: MopetColor.light06),
              ).tr(),
            ],
          ),
        ),
      ],
    );
  }
}
