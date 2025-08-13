import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repo_model.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((_) => FavoritesNotifier());

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});
  bool isFav(Repo r) => state.contains(_key(r));
  void toggle(Repo r) {
    final k = _key(r);
    final next = Set<String>.from(state);
    next.contains(k) ? next.remove(k) : next.add(k);
    state = next;
  }
 
  // 当前收藏数量
  int get count => state.length;

  String _key(Repo r) => '${r.owner}/${r.name}';
}
