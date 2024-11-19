
// 뷰 모델 --> 무조건 StateNotifier 상속 받자
// StateNotifier --> 관리해야 하는 상태값은 뭘까?
// StateNotifier <-- 상태는 캡슐화가 된다.
import 'package:class_riverpod_mvvm/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/post_repository.dart';

// 외부에서 접근하는 상태 변수는 state가 된다. --> T 제네릭이기 때문에 실제 값은 Post 객체이다.
class PostDetailViewModel extends StateNotifier<AsyncValue<Post>> {
  final PostRepository _postRepository;
  final int postId;

  // AsyncValue는 비동기 통신(통신을 할때) 3가지 상태를 구분 지어서 화면을 구성하는데 매우 편리하다.
  // 1 - 로딩, 2 - 데이터, 3 - 오류
  PostDetailViewModel(this._postRepository, this.postId) : super(AsyncValue.loading());

  // 특정 게시글 요청 기능
  Future<void> fetchPostGetById() async {
    try {
      // 응답 받은 post 객체
      final post = await _postRepository.fetchPostById(postId);
      state = AsyncValue.data(post);
    } catch (e, stackTrace) {
      // e : 오류 메세지
      // stackTrace : 개발 시점에 어디서 오류가 발생 했는지 추적 계층 구조를 던져 준다.
      state = AsyncValue.error(e, stackTrace);
      throw Exception('통신중 오류 발생 $e');
    }
  }

}