import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class Perf {
  static bool _installed = false;

  /// Attach a timings callback to log startup and frame metrics in debug/profile.
  static void installTimingsCallback() {
    if (_installed || kReleaseMode) return; // no-op in release
    _installed = true;
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      for (final t in timings) {
        final total = t.totalSpan.inMilliseconds;
        final build = t.buildDuration.inMilliseconds;
        final raster = t.rasterDuration.inMilliseconds;
        dev.log('[FrameTiming] total=${total}ms build=${build}ms raster=${raster}ms');
      }
    });
    dev.log('Perf timings callback installed');
  }
}
