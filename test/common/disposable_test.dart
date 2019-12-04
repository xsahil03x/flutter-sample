import 'package:com_cingulo_sample/common/disposable.dart';
import 'package:flutter_test/flutter_test.dart';

class _ADisposableMixin extends ADisposableMixin {}

class _ADisposeMixin extends ADisposeMixin {}

void main() {
  group('DisposableMixin', () {
    test('did dispose only once', () {
      final disposable = _ADisposableMixin();
      int didDispose1 = 0;
      int didDispose2 = 0;
      expect(disposable.disposableFunctions.length, 0);
      disposable.disposableFunctions.addAll([() => didDispose1++, () => didDispose2++]);
      expect(didDispose1, 0);
      expect(didDispose2, 0);
      expect(disposable.disposableFunctions.length, 2);
      disposable.disposable();
      expect(didDispose1, 1);
      expect(didDispose2, 1);
      expect(disposable.disposableFunctions.length, 0);
      disposable.disposable();
      expect(didDispose1, 1);
      expect(didDispose2, 1);
      expect(disposable.disposableFunctions.length, 0);
    });
  });

  group('DisposeMixin', () {
    test('did dispose only once', () {
      final dispose = _ADisposeMixin();
      int didDispose1 = 0;
      int didDispose2 = 0;
      expect(dispose.disposableFunctions.length, 0);
      dispose.disposableFunctions.addAll([() => didDispose1++, () => didDispose2++]);
      expect(didDispose1, 0);
      expect(didDispose2, 0);
      expect(dispose.disposableFunctions.length, 2);
      dispose.dispose();
      expect(didDispose1, 1);
      expect(didDispose2, 1);
      expect(dispose.disposableFunctions.length, 0);
      dispose.dispose();
      expect(didDispose1, 1);
      expect(didDispose2, 1);
      expect(dispose.disposableFunctions.length, 0);
    });
  });
}
