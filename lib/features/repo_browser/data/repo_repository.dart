import 'github_api.dart';
import 'repo_model.dart';

class RepoRepository {
  RepoRepository(this.api);
  final GithubApi api;

  Future<List<Repo>> search(String keyword) => api.search(keyword);
}
