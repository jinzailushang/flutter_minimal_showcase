import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/dio_client.dart';
import '../data/github_api.dart';
import '../data/repo_model.dart';
import '../data/repo_repository.dart';

// DI graph
final dioProvider = Provider((_) => createDio());
final apiProvider = Provider((ref) => GithubApi(ref.read(dioProvider)));
final repoRepositoryProvider = Provider((ref) => RepoRepository(ref.read(apiProvider)));

class RepoSearchState {
  const RepoSearchState({this.loading = false, this.items = const [], this.error});
  final bool loading;
  final List<Repo> items;
  final String? error;

  RepoSearchState copyWith({bool? loading, List<Repo>? items, String? error}) =>
      RepoSearchState(loading: loading ?? this.loading, items: items ?? this.items, error: error);
}

// Do not construct repository/Dio until actually searching
final repoSearchProvider = StateNotifierProvider<RepoSearchNotifier, RepoSearchState>((ref) {
  return RepoSearchNotifier(ref);
});

class RepoSearchNotifier extends StateNotifier<RepoSearchState> {
  RepoSearchNotifier(this._ref) : super(const RepoSearchState());
  final Ref _ref;

  Future<void> search(String keyword) async {
    state = state.copyWith(loading: true, error: null);
    try {
      // Lazily obtain repository (which creates Dio only now)
      final repo = _ref.read(repoRepositoryProvider);
      final items = await repo.search(keyword);
      state = RepoSearchState(items: items);
    } catch (e) {
      state = RepoSearchState(error: e.toString());
    }
  }
}
