
// 새로운 개념 추가
import 'package:class_riverpod_mvvm/providers/provider/post_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';
import '../../view_models/post_detail_view_model.dart';

final postDetailViewModelProvider
= StateNotifierProvider.family<PostDetailViewModel, AsyncValue<Post>, int>((ref, postId) {
  // 1. postId 값은 family를 통해 전달받은 외부 매개변수로, 특정 게시글을 식별하는데 사용 된다.
  final postRepository = ref.read(postRepositoryProvider);
  return PostDetailViewModel(postRepository, postId);
});