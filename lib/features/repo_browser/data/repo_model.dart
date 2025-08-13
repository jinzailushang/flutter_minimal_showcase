class Repo {
  final String name;
  final String owner;
  final String description;
  final int stars;
  final String url;

  const Repo({
    required this.name,
    required this.owner,
    required this.description,
    required this.stars,
    required this.url,
  });

  factory Repo.fromJson(Map<String, dynamic> j) => Repo(
        name: j['name'] ?? '',
        owner: j['owner']?['login'] ?? '',
        description: j['description'] ?? '',
        stars: j['stargazers_count'] ?? 0,
        url: j['html_url'] ?? '',
      );
}
