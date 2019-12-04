import 'package:com_cingulo_sample/app/app_di.dart';
import 'package:com_cingulo_sample/common/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

class _ADependencyInjectionMixin extends ADependencyInjectionMixin {
  bool didCallDiReady = false;

  @override
  void diReady() {
    didCallDiReady = true;
    super.diReady();
  }
}

void main() {
  group('DependencyInjectionMixin', () {
    test('did inject', () async {
      final di = _ADependencyInjectionMixin();
      expect(di.di, null);
      await di.inject();
      expect(di.di, isA<AppDi>());
    });

    test('did call diReady() after inject()', () async {
      final di = _ADependencyInjectionMixin();
      expect(di.didCallDiReady, false);
      await di.inject();
      expect(di.didCallDiReady, true);
    });
  });
}
