import 'package:dio/dio.dart';
import 'repo_model.dart';
import 'package:flutter/foundation.dart';

class GithubApi {
  GithubApi(this._dio);
  final Dio _dio;

  Future<List<Repo>> search(String keyword) async {
    final r = await _dio.get('search/repositories', queryParameters: {
      'q': (keyword.isEmpty ? 'flutter' : keyword),
      'sort': 'stars',
      'order': 'desc',
      'per_page': 20,
    });
    // Parse on a background isolate to keep UI thread responsive
    return compute(_parseRepos, r.data as Map<String, dynamic>);
  }
}

List<Repo> _parseRepos(Map<String, dynamic> data) {
  final items = (data['items'] as List).cast<Map<String, dynamic>>();
  return items.map((e) => Repo.fromJson(e)).toList();
}
