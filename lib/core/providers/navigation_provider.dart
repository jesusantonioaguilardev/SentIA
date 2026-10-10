import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

@riverpod
class MainTabIndex extends _$MainTabIndex {
  @override
  int build() => 0;

  void setTab(int index) {
    state = index;
  }
}
