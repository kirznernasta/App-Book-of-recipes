import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../../repositories/product_repository.dart';
import '../../../services/image_picker.dart';

part 'product_managing_state.dart';

class ProductManagingCubit extends Cubit<ProductManagingState> {
  final ProductRepository _productRepository;

  ProductManagingCubit({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(ProductManagingState());

  void onNameChanged(String? value) {
    emit(
      state.copyWith(
        newName: value,
      ),
    );
  }

  Future<void> pickImage(bool isFromGallery) async {
    final pickedFile =
        await ImagePicker.pickImage(isFromGallery: isFromGallery);
    if (pickedFile != null) {
      emit(
        state.copyWith(
          newImage: pickedFile.path,
        ),
      );
    }
  }

  Future<void> onApplyButton({
    required bool isEditing,
    required bool isAdmin,
    Product? product,
  }) async {
    assert(!isEditing || isEditing && product != null,
        'if editing mode, product has to be not null');

    if (isEditing) {
      await edit(product!, isAdmin);
    } else {
      await tryCreate(isAdmin);
    }

    reset();
  }

  Future<void> edit(Product product, bool isAdmin) async {
    await _productRepository.update(
      product.copyWith(
        newName: state.name == '' ? product.name : state.name,
        newImage: state.image == '' ? product.image : state.image,
        published: isAdmin,
        requested: !isAdmin,
      ),
    );
  }

  Future<void> tryCreate(bool isAdmin) async {
    emit(
      state.copyWith(
        newErrorMessage: '',
        tryingCreate: true,
      ),
    );
    final products = await _productRepository.receiveAll();
    if (products
        .map((product) => product.name.toLowerCase())
        .contains(state.name.toLowerCase())) {
      emit(
        state.copyWith(
          tryingCreate: false,
          newErrorMessage: 'Product is already exists.',
        ),
      );
    } else {
      final product = Product(
        id: '',
        name: state.name,
        image: state.image,
        isPublished: isAdmin,
        isRequested: !isAdmin,
      );
      await _productRepository.add(product);
      emit(
        state.copyWith(
          newErrorMessage: '',
          tryingCreate: false,
          createdSuccessfully: true,
        ),
      );
    }
  }

  void reset() => emit(
        ProductManagingState(),
      );
}
