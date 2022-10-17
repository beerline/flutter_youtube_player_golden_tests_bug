import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_iframe_example/main.dart';

void main() {
  group('Golden test', () {
    setUpAll(() async {
      SystemChannels.platform_views.setMockMethodCallHandler(
        (MethodCall call) => Future<void>.sync(() {}),
      );
    });

    testGoldens(
      'Golden mobile - Show YouTube player',
      (WidgetTester tester) async {
        tester.binding.window.clearAllTestValues();
        tester.binding.window.physicalSizeTestValue = Size(500, 1000);
        tester.binding.window.devicePixelRatioTestValue = 1;

        // await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          YoutubeApp(),
        );

        for(var i = 1; i < 5; i++ ){
          await tester.pump(const Duration(seconds: 1));
        }
        // });

        await expectLater(
          find.byType(YoutubeApp),
          matchesGoldenFile(
            'goldens/golden_test.png',
          ),
        );
      },

      /// YoutubeVideoPlayer on running test cause error:
      /// 'package:flutter/src/services/platform_views.dart':
      /// Failed assertion: line 1092 pos 12: 'meta != null': is not true.
      // skip: true,
    );
  });
}
