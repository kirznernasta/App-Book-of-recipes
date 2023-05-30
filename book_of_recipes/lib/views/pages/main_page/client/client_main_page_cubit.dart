import 'package:flutter_bloc/flutter_bloc.dart';

part 'client_main_page_state.dart';

class ClientMainPageCubit extends Cubit<ClientMainPageState> {
  ClientMainPageCubit() : super(ClientMainPageState());

  void changeSelectedIndex(int index) => emit(
        state.copyWith(
          changedSelectedIndex: index,
        ),
      );
}
