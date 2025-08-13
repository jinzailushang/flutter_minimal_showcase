import 'package:flutter/material.dart';
import '../../data/repo_model.dart';

class RepoTile extends StatelessWidget {
  const RepoTile({super.key, required this.repo, required this.onTap, required this.onFav, required this.isFav});
  final Repo repo;
  final VoidCallback onTap;
  final VoidCallback onFav;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${repo.owner}/${repo.name}', maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(repo.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.star, size: 16), const SizedBox(width: 4), Text('${repo.stars}'),
        IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border), onPressed: onFav)
      ]),
      onTap: onTap,
    );
  }
}
