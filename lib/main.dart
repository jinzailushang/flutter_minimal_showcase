import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'common/perf.dart';

void main() {
  // Required to access SchedulerBinding before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // For debug/profile only; no-op in release
  Perf.installTimingsCallback();
  runApp(const ProviderScope(child: App()));
}
