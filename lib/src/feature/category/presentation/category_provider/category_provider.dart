import 'package:admin_dashboard/src/feature/category/business/usecase/category_add_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_categories_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_update_usecase.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/param/category_add_param.dart';
import '../../business/usecase/category_delete_usecase.dart';
import '../../business/usecase/category_get_category_by_id_usecase.dart';
import '../../business/usecase/category_get_signed_url_usecase.dart';
import '../../business/usecase/category_upload_image_usecase.dart';
import '../../data/model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryAddUseCase categoryAddUseCase;
  final CategoryGetCategoriesUseCase categoryGetCategoriesUseCase;
  final CategoryGetCategoryByIdUseCase categoryGetCategoryByIdUseCase;
  final CategoryUpdateUseCase categoryUpdateCategoryUseCase;
  final CategoryUploadImageUseCase categoryUploadImageUseCase;
  final CategoryGetSignedUrlUseCase categoryGetSignedUrlUseCase;
  final CategoryDeleteUseCase categoryDeleteUseCase;

  CategoryProvider({
    required this.categoryAddUseCase,
    required this.categoryGetCategoriesUseCase,
    required this.categoryGetCategoryByIdUseCase,
    required this.categoryUpdateCategoryUseCase,
    required this.categoryUploadImageUseCase,
    required this.categoryGetSignedUrlUseCase,
    required this.categoryDeleteUseCase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  CategoryModel? _categoryModel;

  CategoryModel? get categoryModel => _categoryModel;

  void setCategoryModel(CategoryModel? value) {
    _categoryModel = value;
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

  TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void setTextController(String value) {
    _searchController.text = value;
    notifyListeners();
  }

  List<CategoryModel> _categoryList = [];

  List<CategoryModel> get categoryList => _categoryList;

  void setCategoryList(List<CategoryModel> value) {
    _categoryList = value;
    notifyListeners();
  }

  void getCategories() async {
    _isLoading = true;
    notifyListeners();
    List<CategoryModel> categoryList = [];
    final result = await categoryGetCategoriesUseCase.call(NoParams());

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;
    }, (r) async {
      print(r);
      categoryList = r;
    });

    _categoryList = categoryList;
    _isLoading = false;
    notifyListeners();
  }

  Future<List<CategoryModel>?> getCategoriesAsync() async {
    List<CategoryModel> categoryList = [];

    final result = await categoryGetCategoriesUseCase.call(NoParams());

    await result.fold((l) async {
      return null;
    }, (r) async {
      print(r);
      categoryList = r;
    });

    return categoryList;
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

  String _addCategoryErrorMessage = '';

  String get addCategoryErrorMessage => _addCategoryErrorMessage;

  void setAddCategoryErrorMessage(String value) {
    _addCategoryErrorMessage = value;
    notifyListeners();
  }

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void setExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  Future<String?> uploadImage(Uint8List bytes) async {
    _isLoading = true;
    String? url;
    notifyListeners();
    final result = await categoryUploadImageUseCase.call(bytes);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

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

    final result = await categoryGetSignedUrlUseCase.call(path);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    return url;
  }

  Future<bool> addCategory(String name, String? description, String imageUrl, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    bool isSuccess = false;
    final result = await categoryAddUseCase.call(CategoryAddParam(
      name: name,
      description: description,
      imageUrl: imageUrl,
    ));

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Error!'),
            content: fluent.RichText(
                text: fluent.TextSpan(
              text: 'The user has not been added because of an error. ',
              children: [
                fluent.TextSpan(
                  text: l.errorMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),

            /*'The user has not been added because of an error. ${l.errorMessage}'*/

            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.error,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );

      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Success!'),
            content: const Text('The category has been added successfully. You can add another category or close the form.'),
            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.success,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    CategoryModel? categoryModel;
    final result = await categoryGetCategoryByIdUseCase.call(id);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;
    }, (r) async {
      print(r.toJson());
      categoryModel = CategoryModel.fromJson(r.toJson());
    });

    return categoryModel;
  }

  Future<bool> updateCategory(CategoryModel category, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    bool isSuccess = false;
    CategoryModel? categoryModel;
    final result = await categoryUpdateCategoryUseCase.call(category);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Error!'),
            content: fluent.RichText(
                text: fluent.TextSpan(
              text: 'The user has not been added because of an error. ',
              children: [
                fluent.TextSpan(
                  text: l.errorMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )),

            /*'The user has not been added because of an error. ${l.errorMessage}'*/

            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.error,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      await fluent.displayInfoBar(
        context,
        builder: (context, close) {
          return fluent.InfoBar(
            title: const Text('Success!'),
            content: const Text('The category has been added successfully. You can add another category or close the form.'),
            action: IconButton(
              icon: const Icon(fluent.FluentIcons.clear),
              onPressed: close,
            ),
            severity: fluent.InfoBarSeverity.success,
          );
        },
        alignment: Alignment.topRight,
        duration: const Duration(seconds: 5),
      );
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }

  Future<bool> deleteCategory(int id) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await categoryDeleteUseCase.call(id);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

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
