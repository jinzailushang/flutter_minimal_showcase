import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/logic/favorites_provider.dart';
import 'package:flutter_minimal_showcase/features/repo_browser/data/repo_model.dart';

void main() {
  group('FavoritesNotifier', () {
    test('toggle add/remove and count', () {
      final notifier = FavoritesNotifier();
      const repo = Repo(
        name: 'flutter',
        owner: 'flutter',
        description: 'desc',
        stars: 1,
        url: 'https://example.com',
      );

      expect(notifier.count, 0);
      expect(notifier.isFav(repo), false);

      notifier.toggle(repo);
      expect(notifier.isFav(repo), true);
      expect(notifier.count, 1);

      notifier.toggle(repo);
      expect(notifier.isFav(repo), false);
      expect(notifier.count, 0);
    });
  });
}
