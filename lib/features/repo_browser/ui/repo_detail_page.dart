import 'package:flutter/material.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({super.key, required this.owner, required this.name});
  final String owner;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$owner/$name')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('仓库详情：$owner/$name', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const Text('这里可以扩展：README 片段、贡献者列表、问题单等。可扩展方案：分页加载、离线缓存、错误态与重试。'),
            ],
          ),
        ),
      ),
    );
  }
}
