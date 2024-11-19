import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. PostCreateViewModel을 생성한다.
// 2. PostCreateViewModel을 관리하는 프로바이더를 생성한다.
// 3. PostCreatePage 뷰 화면을 구성한다.

class PostCreatePage extends ConsumerStatefulWidget {
  const PostCreatePage({super.key});

  @override
  ConsumerState<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends ConsumerState<PostCreatePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
