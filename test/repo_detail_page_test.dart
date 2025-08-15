import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_minimal_showcase/features/repo_browser/ui/repo_detail_page.dart';

void main() {
  testWidgets('RepoDetailPage shows owner/name and detail text', (tester) async {
    const owner = 'flutter';
    const name = 'flutter';

    await tester.pumpWidget(const MaterialApp(
      home: RepoDetailPage(owner: owner, name: name),
    ));

    expect(find.text('$owner/$name'), findsOneWidget); // AppBar title
    expect(find.text('仓库详情：$owner/$name'), findsOneWidget);
  });
}
