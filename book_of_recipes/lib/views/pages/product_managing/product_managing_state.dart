part of 'product_managing_cubit.dart';

class ProductManagingState {
  final String name;
  final String image;
  final String errorMessage;
  final bool isTryingCreate;
  final bool isCreatedSuccessfully;

  ProductManagingState({
    this.name = '',
    this.image = '',
    this.errorMessage = '',
    this.isTryingCreate = false,
    this.isCreatedSuccessfully = false,
  });

  bool get isCanCreate => name != '' && image != '';

  ProductManagingState copyWith({
    String? newName,
    String? newImage,
    String? newErrorMessage,
    bool? tryingCreate,
    bool? createdSuccessfully,
  }) =>
      ProductManagingState(
        name: newName ?? name,
        image: newImage ?? image,
        errorMessage: newErrorMessage ?? errorMessage,
        isTryingCreate: tryingCreate ?? isTryingCreate,
        isCreatedSuccessfully: createdSuccessfully ?? isCreatedSuccessfully,
      );
}
