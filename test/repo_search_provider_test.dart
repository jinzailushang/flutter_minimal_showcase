import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:flutter_minimal_showcase/features/repo_browser/logic/repo_search_provider.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_model.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_repository.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/github_api.dart';

class _FakeRepoRepository extends RepoRepository {
  _FakeRepoRepository(this._items, {this.throwError = false})
      : super(GithubApi(Dio()));
  final List<Repo> _items;
  final bool throwError;

  @override
  Future<List<Repo>> search(String keyword) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    if (throwError) throw Exception('boom');
    return _items;
  }
}

void main() {
  group('repoSearchProvider', () {
    test('success path sets items and clears loading', () async {
      final items = [
        const Repo(
          name: 'flutter',
          owner: 'flutter',
          description: 'd',
          stars: 1,
          url: 'https://example.com',
        ),
      ];

      final container = ProviderContainer(
        overrides: [
          repoRepositoryProvider.overrideWith((ref) => _FakeRepoRepository(items)),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(repoSearchProvider.notifier);
      expect(container.read(repoSearchProvider).loading, false);

      final future = notifier.search('flutter');
      // loading should be true immediately after calling
      expect(container.read(repoSearchProvider).loading, true);

      await future;
      final state = container.read(repoSearchProvider);
      expect(state.loading, false);
      expect(state.error, isNull);
      expect(state.items, isNotEmpty);
      expect(state.items.first.name, 'flutter');
    });

    test('error path sets error and no items', () async {
      final container = ProviderContainer(
        overrides: [
          repoRepositoryProvider.overrideWith((ref) => _FakeRepoRepository(const [], throwError: true)),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(repoSearchProvider.notifier);
      await notifier.search('x');
      final state = container.read(repoSearchProvider);
      expect(state.loading, false);
      expect(state.items, isEmpty);
      expect(state.error, isNotNull);
    });
  });
}
