import 'package:class_riverpod_mvvm/models/post.dart';
import 'package:class_riverpod_mvvm/providers/state_noti_provider/post_list_view_model_provider.dart';
import 'package:class_riverpod_mvvm/view/post/post_create_page.dart';
import 'package:class_riverpod_mvvm/view/post/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// MVVM --> View 는 뷰 모델 인스턴스만 바라보면 된다.
// ConsumerWidget은 Provider 상태를 구독하여, 상태가 변경될 때 자동으로
// UI 가 업데이트 되도록 설계가 가능 하다.
class PostListPage extends ConsumerWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(postListViewModelProvider.notifier).fetchPosts();
    // 게시글에 리스트 화면을 구현해야 한다.
    // 뷰 모델을 관리하는 Provider를 호출하는데 계속 관찰하는 입장이다.
    final postList = ref.watch(postListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 목록 화면'),
      ),
      body: postList.isEmpty
          ? Center(
              child: Text('게시글이 존재하지 않습니다.'),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                Post post = postList[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PostDetailPage(postId: post.id);
                    }));
                  },
                  title: Text(
                    post.title,
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                  subtitle: Text(post.body),
                  trailing: IconButton(
                    onPressed: () async {
                      bool confirm = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('삭제'),
                          content: Text('${post.title} 를 삭제 하시겠습니까?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('취소')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('확인')),
                          ],
                        ),
                      );
                      // 뷰모델에 접근해서 deletePost() 메서드를 호출해야 한다.
                      // 상태를 그냥 보는 것은 직접 접근이 가능하다.
                      // 해당하는 Provider에 상태 변경 요청은 창고 관리자에게 의뢰해야 한다.
                      if (confirm) {
                        await ref
                            .read(postListViewModelProvider.notifier)
                            .deletePost(post.id!);
                        // 삭제 완료 후 스낵 바로 피드백 제공
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('삭제 완료')));
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
              itemCount: postList.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostCreatePage())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
