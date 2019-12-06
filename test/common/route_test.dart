import 'package:com_cingulo_sample/common/route.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';

class _ARoute extends ARoute {
  @override
  String path = '/route';

  @override
  Widget handlerFunc(BuildContext context, Map<String, dynamic> params) {
    return null;
  }
}

void main() {
  group('ARoute', () {
    final route = _ARoute();

    test('has path', () {
      expect(route.path, isA<String>());
      expect(route.path, '/route');
    });

    test('has replace', () {
      expect(route.replace, false);
    });

    test('has clearStack', () {
      expect(route.clearStack, false);
    });

    test('has transition', () {
      expect(route.transition, TransitionType.native);
    });

    test('has transitionDuration', () {
      expect(route.transitionDuration, Duration(milliseconds: 250));
    });

    test('has transitionBuilder', () {
      expect(route.transitionBuilder, null);
    });

    test('has handlerFunc', () {
      expect(route.handlerFunc(null, null), null);
    });

    test('has hasPermission', () async {
      final hasPermission = await route.hasPermission({
        'foo': ['bar'],
      });
      expect(hasPermission, true);
    });
  });
}
