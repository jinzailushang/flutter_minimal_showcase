import 'package:go_router/go_router.dart';
import 'features/repo_browser/ui/repo_list_page.dart';
import 'features/repo_browser/ui/repo_detail_page.dart';

GoRouter createRouter() => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const RepoListPage()),
    GoRoute(path: '/detail/:owner/:name', builder: (ctx, st) {
      final owner = st.pathParameters['owner']!;
      final name  = st.pathParameters['name']!;
      return RepoDetailPage(owner: owner, name: name);
    }),
  ],
);
