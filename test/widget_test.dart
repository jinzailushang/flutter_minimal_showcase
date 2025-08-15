import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:flutter_minimal_showcase/app.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/logic/repo_search_provider.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_repository.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/github_api.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_model.dart';

class _FakeRepoRepository extends RepoRepository {
  _FakeRepoRepository(this._items) : super(GithubApi(Dio()));
  final List<Repo> _items;
  @override
  Future<List<Repo>> search(String keyword) async => _items;
}

void main() {
  testWidgets('App smoke test: renders repo list page UI', (WidgetTester tester) async {
    final overrides = [
      repoRepositoryProvider.overrideWith((ref) => _FakeRepoRepository(const [])),
    ];

    await tester.pumpWidget(ProviderScope(overrides: overrides, child: const App()));
    await tester.pumpAndSettle();

    // Verify presence of search UI and app bar text (favorites count starts at 0)
    expect(find.byType(TextField), findsOneWidget);
    expect(find.textContaining('开源仓库浏览'), findsOneWidget);
  });
}
