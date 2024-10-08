import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckAuthStatusScreen extends ConsumerWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* ref.listen(authProvider, (previous, next) {
      context.go('/');
    }); */
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LinearProgressIndicator(borderRadius: BorderRadius.circular(10), ),
        ),
      ),
    );
  }
}