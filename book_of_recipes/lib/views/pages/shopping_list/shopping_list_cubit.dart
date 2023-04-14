import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  ShoppingListCubit() : super(ShoppingListState());
}
