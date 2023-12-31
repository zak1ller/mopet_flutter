import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingView extends ConsumerWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
