import 'package:admin_dashboard/src/feature/category/business/usecase/category_add_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_categories_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_update_usecase.dart';
import 'package:admin_dashboard/src/feature/product/data/model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/usecase/usecase.dart';

import '../../business/param/product_add_param.dart';
import '../../business/usecase/product_add_usecase.dart';
import '../../business/usecase/product_delete_usecase.dart';
import '../../business/usecase/product_get_products_usecase.dart';
import '../../business/usecase/product_get_product_by_id_usecase.dart';
import '../../business/usecase/product_get_signed_url_usecase.dart';
import '../../business/usecase/product_update_usecase.dart';
import '../../business/usecase/product_upload_image_usecase.dart';

class ProductProvider with ChangeNotifier {
  final ProductAddUseCase productAddUseCase;
  final ProductGetProductsUseCase productGetProductsUseCase;
  final ProductGetProductByIdUseCase productGetProductByIdUseCase;
  final ProductUpdateUseCase productUpdateProductUseCase;
  final ProductUploadImageUseCase productUploadImageUseCase;
  final ProductGetSignedUrlUseCase productGetSignedUrlUseCase;
  final ProductDeleteUseCase productDeleteUseCase;

  ProductProvider({
    required this.productAddUseCase,
    required this.productGetProductsUseCase,
    required this.productGetProductByIdUseCase,
    required this.productUpdateProductUseCase,
    required this.productUploadImageUseCase,
    required this.productGetSignedUrlUseCase,
    required this.productDeleteUseCase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProductModel? _productModel;

  ProductModel? get productModel => _productModel;

  void setProductModel(ProductModel? value) {
    _productModel = value;
    notifyListeners();
  }

  int _nbItemPerPage = 10;

  int get nbItemPerPage => _nbItemPerPage;

  void setNbItemPerPage(int value) {
    _nbItemPerPage = value;
    notifyListeners();
  }

  String _searchText = '';

  String get searchText => _searchText;

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  int _selectedIndexCategory = 0;

  int get selectedIndexCategory => _selectedIndexCategory;

  void setSelectedIndexCategory(int value) {
    _selectedIndexCategory = value;
    notifyListeners();
  }

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void setTextController(String value) {
    _searchController.text = value;
    notifyListeners();
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    ImageSource source = ImageSource.gallery;
    if (!kIsWeb) {
      Get.dialog(
        AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Camera'),
                onTap: () {
                  source = ImageSource.camera;
                  Get.back();
                },
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () {
                  source = ImageSource.gallery;
                  Get.back();
                },
              ),
            ],
          ),
        ),
      );
    }
    final XFile? image = await picker.pickImage(source: source);
    return image;
  }

  String _addProductErrorMessage = '';

  String get addProductErrorMessage => _addProductErrorMessage;

  void setAddProductErrorMessage(String value) {
    _addProductErrorMessage = value;
    notifyListeners();
  }

  Future<String?> uploadImage(Uint8List bytes) async {
    _isLoading = true;
    String? url;
    notifyListeners();
    final result = await productUploadImageUseCase.call(bytes);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    _isLoading = false;
    notifyListeners();
    return url;
  }

  Future<String?> getSignedUrl(String path) async {
    path = path.split('/').last;
    String? url;

    final result = await productGetSignedUrlUseCase.call(path);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    return url;
  }

  Future<bool> addProduct(String name, String? description, String imageUrl,
      double price, int categoryId) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await productAddUseCase.call(ProductAddParam(
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      categoryId: categoryId,
    ));

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;

      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<ProductModel?> getProductById(int id) async {
    ProductModel? productModel;
    final result = await productGetProductByIdUseCase.call(id);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;
    }, (r) async {
      print(r.toJson());
      productModel = ProductModel.fromJson(r.toJson());
    });

    return productModel;
  }

  Future<ProductModel?> updateProduct(ProductModel product) async {
    _isLoading = true;
    notifyListeners();
    ProductModel? productModel;
    final result = await productUpdateProductUseCase.call(product);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;
    }, (r) async {
      print(r.toJson());
      productModel = ProductModel.fromJson(r.toJson());
    });

    _isLoading = false;
    notifyListeners();

    return productModel;
  }

  Future<bool> deleteProduct(int id) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await productDeleteUseCase.call(id);

    await result.fold((l) async {
      _addProductErrorMessage = l.errorMessage;
      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}
