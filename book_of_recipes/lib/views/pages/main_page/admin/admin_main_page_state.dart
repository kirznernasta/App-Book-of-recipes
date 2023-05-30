part of 'admin_main_page_cubit.dart';

class AdminMainPageState {
  final int selectedIndex;

  AdminMainPageState({
    this.selectedIndex = 0,
  });

  AdminMainPageState copyWith({
    int? changedSelectedIndex,
  }) =>
      AdminMainPageState(
        selectedIndex: changedSelectedIndex ?? selectedIndex,
      );
}
