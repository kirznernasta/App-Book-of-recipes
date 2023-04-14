part of 'main_page_cubit.dart';

class MainPageState {
  final int selectedIndex;

  MainPageState({
    this.selectedIndex = 0,
  });

  MainPageState copyWith({
    int? changedSelectedIndex,
  }) =>
      MainPageState(
        selectedIndex: changedSelectedIndex ?? selectedIndex,
      );
}
