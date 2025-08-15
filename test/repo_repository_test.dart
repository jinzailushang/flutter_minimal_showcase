import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:flutter_minimal_showcase/features/repo_browser/data/github_api.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_repository.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_model.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  test('RepoRepository.search returns list', () async {
    final dio = _MockDio();
    when(() => dio.get(any(), queryParameters: any(named: 'queryParameters')))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              data: {
                'items': [
                  {
                    'name': 'flutter',
                    'owner': {'login': 'flutter'},
                    'description': 'desc',
                    'stargazers_count': 1,
                    'html_url': 'https://example.com'
                  }
                ]
              },
            ));

    final api = GithubApi(dio);
    final repo = RepoRepository(api);

    final res = await repo.search('flutter');
    expect(res, isA<List<Repo>>());
    expect(res.first.name, 'flutter');
  });
}
