import 'package:admin_dashboard/src/core/constant/route.dart';
import 'package:admin_dashboard/src/feature/auth/business/repository/auth_repository.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_get_user_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_is_looged_in_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_login_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_logout_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_on_auth_change_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/data/datasource/auth_datasource.dart';
import 'package:admin_dashboard/src/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_add_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_delete_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_categories_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_category_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_signed_url_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_update_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_upload_image_usecase.dart';
import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:admin_dashboard/src/feature/category/data/repository/category_repository_impl.dart';
import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_add_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_delete_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_get_customer_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_get_customers_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/business/usecase/customer_update_usecase.dart';
import 'package:admin_dashboard/src/feature/customer/data/datasource/customer_datasource.dart';
import 'package:admin_dashboard/src/feature/customer/data/repository/customer_repository_impl.dart';
import 'package:admin_dashboard/src/feature/customer/presentation/provider/customer_provider.dart';
import 'package:admin_dashboard/src/feature/home/presentation/provider/home_provider.dart';
import 'package:admin_dashboard/src/feature/ingredient/business/repository/ingredient_repository.dart';
import 'package:admin_dashboard/src/feature/ingredient/business/usecase/ingredient_add_usecase.dart';
import 'package:admin_dashboard/src/feature/ingredient/business/usecase/ingredient_get_ingredients_usecase.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/datasource/ingredient_datasource.dart';
import 'package:admin_dashboard/src/feature/ingredient/data/repository/ingredient_repository_impl.dart';
import 'package:admin_dashboard/src/feature/ingredient/presentation/provider/ingredient_provider.dart';
import 'package:admin_dashboard/src/feature/order/business/usecase/order_get_order_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/order/business/usecase/order_get_orders_by_customer_id_usecase.dart';
import 'package:admin_dashboard/src/feature/order/business/usecase/order_get_orders_by_date_usecase.dart';
import 'package:admin_dashboard/src/feature/order/data/datasource/order_datasource.dart';
import 'package:admin_dashboard/src/feature/order/data/repository/order_repository_impl.dart';
import 'package:admin_dashboard/src/feature/order/presentation/provider/order_provider.dart';
import 'package:admin_dashboard/src/feature/product/business/repository/product_repository.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_add_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_delete_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_get_product_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_get_products_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_get_signed_url_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_update_usecase.dart';
import 'package:admin_dashboard/src/feature/product/business/usecase/product_upload_image_usecase.dart';
import 'package:admin_dashboard/src/feature/product/data/datasource/product_datasource.dart';
import 'package:admin_dashboard/src/feature/product/data/repository/product_repository_impl.dart';
import 'package:admin_dashboard/src/feature/product/presentation/provider/product_provider.dart';
import 'package:admin_dashboard/src/feature/recipe/business/repository/recipe_repository.dart';
import 'package:admin_dashboard/src/feature/recipe/business/usecase/recipe_add_usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/business/usecase/recipe_get_ingredients_usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/business/usecase/recipe_get_recipe_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/recipe/data/datasource/recipe_datasource.dart';
import 'package:admin_dashboard/src/feature/recipe/data/repository/recipe_repository_impl.dart';
import 'package:admin_dashboard/src/feature/recipe/presentation/provider/recipe_provider.dart';
import 'package:admin_dashboard/src/feature/theme/presentation/provider/theme_provider.dart';
import 'package:admin_dashboard/src/feature/track_issue/business/usecase/track_issue_get_all_track_issues_usecase.dart';
import 'package:admin_dashboard/src/feature/track_issue/business/usecase/track_issue_update_track_issue_usecase.dart';
import 'package:admin_dashboard/src/feature/track_issue/data/datasource/track_issue_datasource.dart';
import 'package:admin_dashboard/src/feature/track_issue/data/repository/track_issue_repository_impl.dart';
import 'package:admin_dashboard/src/feature/track_issue/presentation/provider/track_issue_provider.dart';
import 'package:admin_dashboard/src/feature/user/business/repository/user_repository.dart';
import 'package:admin_dashboard/src/feature/user/business/usecase/user_add_usecase.dart';
import 'package:admin_dashboard/src/feature/user/business/usecase/user_delete_usecase.dart';
import 'package:admin_dashboard/src/feature/user/business/usecase/user_get_user_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/user/business/usecase/user_get_users_usecase.dart';
import 'package:admin_dashboard/src/feature/user/business/usecase/user_update_usecase.dart';
import 'package:admin_dashboard/src/feature/user/data/datasource/user_datasource.dart';
import 'package:admin_dashboard/src/feature/user/data/repository/user_repository_impl.dart';
import 'package:admin_dashboard/src/feature/user/presentation/provider/user_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
/*
import 'package:paged_datatable/l10n/generated/l10n.dart';
*/
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qlhzemdpzbonyqdecfxn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODY4MDYsImV4cCI6MjAyMDQ2MjgwNn0.lcUJMI3dvMDT7LaO7MiudIkdxAZOZwF_hNtkQtF3OC8',
  );

  final supabaseAdmin = SupabaseClient('https://qlhzemdpzbonyqdecfxn.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODY4MDYsImV4cCI6MjAyMDQ2MjgwNn0.lcUJMI3dvMDT7LaO7MiudIkdxAZOZwF_hNtkQtF3OC8');
  final supabaseClient = Supabase.instance;
  AuthRepository authRepository = AuthRepositoryImpl(dataSource: AuthDataSource());
  CategoryRepository categoryRepository = CategoryRepositoryImpl(dataSource: CategoryDataSource());
  ProductRepository productRepository = ProductRepositoryImpl(dataSource: ProductDataSource());
  UserRepository userRepository = UserRepositoryImpl(dataSource: UserDataSource());
  CustomerRepositoryImpl customerRepository = CustomerRepositoryImpl(dataSource: CustomerDataSource());
  TrackIssueRepositoryImpl trackIssueRepository = TrackIssueRepositoryImpl(dataSource: TrackIssueDataSource());

  OrderRepositoryImpl orderRepository = OrderRepositoryImpl(
    orderDataSource: OrderDataSource(),
  );

  IngredientRepository ingredientRepository = IngredientRepositoryImpl(
    dataSource: IngredientDataSource(),
  );

  RecipeRepository recipeRepository = RecipeRepositoryImpl(dataSource: RecipeDataSource());
  // set path strategy
  usePathUrlStrategy();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            authLoginUseCase: AuthLoginUseCase(authRepository: authRepository),
            authLogoutUseCase: AuthLogoutUseCase(authRepository: authRepository),
            authGetUserUseCase: AuthGetUserUseCase(authRepository: authRepository),
            authIsLoggedInUseCase: AuthIsLoggedInUseCase(authRepository: authRepository),
            authOnAuthChangeUseCase: AuthOnAuthOnAuthChangeUseCase(authRepository: authRepository),
          ),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(
            categoryAddUseCase: CategoryAddUseCase(categoryRepository: categoryRepository),
            categoryGetCategoriesUseCase: CategoryGetCategoriesUseCase(categoryRepository: categoryRepository),
            categoryGetCategoryByIdUseCase: CategoryGetCategoryByIdUseCase(categoryRepository: categoryRepository),
            categoryUpdateCategoryUseCase: CategoryUpdateUseCase(categoryRepository: categoryRepository),
            categoryUploadImageUseCase: CategoryUploadImageUseCase(categoryRepository: categoryRepository),
            categoryGetSignedUrlUseCase: CategoryGetSignedUrlUseCase(categoryRepository: categoryRepository),
            categoryDeleteUseCase: CategoryDeleteUseCase(categoryRepository: categoryRepository),
          ),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(
            productAddUseCase: ProductAddUseCase(productRepository: productRepository),
            productGetProductsUseCase: ProductGetProductsUseCase(productRepository: productRepository),
            productGetProductByIdUseCase: ProductGetProductByIdUseCase(productRepository: productRepository),
            productUpdateProductUseCase: ProductUpdateUseCase(productRepository: productRepository),
            productUploadImageUseCase: ProductUploadImageUseCase(productRepository: productRepository),
            productGetSignedUrlUseCase: ProductGetSignedUrlUseCase(productRepository: productRepository),
            productDeleteUseCase: ProductDeleteUseCase(productRepository: productRepository),
          ),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            userAddUseCase: UserAddUseCase(userRepository: userRepository),
            userGetUsersUseCase: UserGetUsersUseCase(userRepository: userRepository),
            userGetUserByIdUseCase: UserGetUserByIdUseCase(userRepository: userRepository),
            userUpdateUserUseCase: UserUpdateUseCase(userRepository: userRepository),
            userDeleteUseCase: UserDeleteUseCase(userRepository: userRepository),
          ),
        ),
        ChangeNotifierProvider<CustomerProvider>(
          create: (context) => CustomerProvider(
            customerAddUseCase: CustomerAddUseCase(customerRepository: customerRepository),
            customerUpdateUseCase: CustomerUpdateUseCase(customerRepository: customerRepository),
            customerDeleteUseCase: CustomerDeleteUseCase(customerRepository: customerRepository),
            customerGetCustomerByIdUseCase: CustomerGetCustomerByIdUseCase(customerRepository: customerRepository),
            customerGetCustomersUseCase: CustomerGetCustomersUseCase(customerRepository: customerRepository),
          ),
        ),
        ChangeNotifierProvider<IngredientProvider>(
          create: (context) => IngredientProvider(ingredientGetIngredientsUseCase: IngredientGetIngredientsUseCase(ingredientRepository: ingredientRepository), ingredientAddUseCase: IngredientAddUseCase(ingredientRepository: ingredientRepository)),
        ),
        ChangeNotifierProvider<RecipeProvider>(
          create: (context) => RecipeProvider(
            recipeGetRecipesUseCase: RecipeGetRecipesUseCase(recipeRepository: recipeRepository),
            recipeAddUseCase: RecipeAddUseCase(recipeRepository: recipeRepository),
            recipeGetRecipeByIdUseCase: RecipeGetRecipeByIdUseCase(recipeRepository: recipeRepository),
          ),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(
            orderGetOrdersByDateUseCase: OrderGetOrdersByDateUseCase(orderRepository: orderRepository),
            orderGetOrdersByCustomerIdUseCase: OrderGetOrdersByCustomerIdUseCase(orderRepository: orderRepository),
            orderGetOrdersByIdUseCase: OrderGetOrdersByIdUseCase(orderRepository: orderRepository),
          ),
        ),
        ChangeNotifierProvider<TrackIssueProvider>(
          create: (context) => TrackIssueProvider(
            getAllTrackIssuesUsecase: TrackIssueGetAllTrackIssuesUsecase(repository: trackIssueRepository),
            updateTrackIssueUsecase: TrackIssueUpdateTrackIssueUsecase(repository: trackIssueRepository),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  GoRouter? router;

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    context.read<ThemeProvider>().getThemeMode();
    router = RouterHelper().getRouter(context);
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
/*
        PagedDataTableLocalization.delegate
*/
      ],
      supportedLocales: const [Locale("es"), Locale("en")],
      locale: const Locale("en"),
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      themeMode: context.watch<ThemeProvider>().themeMode == 'system'
          ? ThemeMode.system
          : context.watch<ThemeProvider>().themeMode == 'light'
              ? ThemeMode.light
              : ThemeMode.dark,
      /* defaultTransition: Transition.fadeIn,
      scaffoldMessengerKey: scaffoldMessengerKey,*/
      routerDelegate: router!.routerDelegate,
      routeInformationParser: router!.routeInformationParser,
      routeInformationProvider: router!.routeInformationProvider,
      /* routingCallback: (routing) {
        print('route: ${routing?.current}');

        if (routing?.current == '/login') {
          if (context.read<AuthProvider>().checkIsLoggedIn()) {
            routing?.current = '/home';
          }
        } else {
          if (!context.read<AuthProvider>().checkIsLoggedIn()) {
            routing?.current = '/login';
          }
        }
      },*/
      /*getPages: Routes().getPages,
      initialRoute: '/login',
      home: StreamBuilder<AuthState>(
        stream: context.read<AuthProvider>().onAuthStateChange(),
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInScreen();
            } else {
              return const HomeScreen();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),*/
    );
  }
}
