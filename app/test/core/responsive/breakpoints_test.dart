import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/responsive/breakpoints.dart';

void main() {
  test('WindowSize.fromWidth respeta los límites de docs/04', () {
    expect(WindowSize.fromWidth(360), WindowSize.compact);
    expect(WindowSize.fromWidth(599.9), WindowSize.compact);
    expect(WindowSize.fromWidth(600), WindowSize.medium);
    expect(WindowSize.fromWidth(839.9), WindowSize.medium);
    expect(WindowSize.fromWidth(840), WindowSize.expanded);
    expect(WindowSize.fromWidth(1280), WindowSize.expanded);
  });
}
