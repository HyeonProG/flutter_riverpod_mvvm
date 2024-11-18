import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 우리 앱에서 사용하는 모든 Provider를 하나의 컨테이너(ProviderContainer)로 묶어서 관리 한다.
void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: NovaBlog(),
      ),
    ),
  );
}

class NovaBlog extends StatelessWidget {
  const NovaBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
