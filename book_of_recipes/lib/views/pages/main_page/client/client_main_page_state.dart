part of 'client_main_page_cubit.dart';

class ClientMainPageState {
  final int selectedIndex;

  ClientMainPageState({
    this.selectedIndex = 0,
  });

  ClientMainPageState copyWith({
    int? changedSelectedIndex,
  }) =>
      ClientMainPageState(
        selectedIndex: changedSelectedIndex ?? selectedIndex,
      );
}
