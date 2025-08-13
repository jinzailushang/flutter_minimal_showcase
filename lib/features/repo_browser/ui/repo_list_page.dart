import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../logic/repo_search_provider.dart';
import '../logic/favorites_provider.dart';
import 'widgets/repo_tile.dart';

class RepoListPage extends ConsumerStatefulWidget {
  const RepoListPage({super.key});
  @override
  ConsumerState<RepoListPage> createState() => _RepoListPageState();
}

class _RepoListPageState extends ConsumerState<RepoListPage> {
  final _controller = TextEditingController(text: 'flutter');

  @override
  void initState() {
    super.initState();
    // Defer network request to the first frame callback so first paint is not delayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(repoSearchProvider.notifier).search(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(repoSearchProvider);
    final favs = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: Text('开源仓库浏览 · 收藏 ${favs.length}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '搜索开源仓库…',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => ref.read(repoSearchProvider.notifier).search(_controller.text),
                ),
              ),
              onSubmitted: (v) => ref.read(repoSearchProvider.notifier).search(v),
            ),
          ),
          if (state.loading) const LinearProgressIndicator(),
          if (state.error != null)
            ListTile(
              title: Text('出错了：${state.error}'),
              trailing: TextButton(
                onPressed: () => ref.read(repoSearchProvider.notifier).search(_controller.text),
                child: const Text('重试'),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (_, i) {
                final r = state.items[i];
                final isFav = favs.contains('${r.owner}/${r.name}');
                return RepoTile(
                  repo: r,
                  isFav: isFav,
                  onFav: () => ref.read(favoritesProvider.notifier).toggle(r),
                  onTap: () => context.push('/detail/${r.owner}/${r.name}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
