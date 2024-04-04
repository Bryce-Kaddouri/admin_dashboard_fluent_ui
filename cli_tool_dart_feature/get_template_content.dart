import 'dart:io';

String getRepositoryTemplate(String featureName) {
  // read content file from cli_tool/templates/repository_template.dart
  String content = File('templates/repository_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  content = content.replaceAll('feature_name', featureName);

  featureName = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureName);

  print('Repository template generated successfully');
  return content;
}

String getModelTemplate(String featureName) {
  // read content file from cli_tool/templates/model_template.dart
  String content = File('templates/model_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  featureName = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureName);

  print('Model template generated successfully');
  return content;
}

String getDataSourceTemplate(String featureName) {
  // read content file from cli_tool/templates/datasource_template.dart
  String content = File('templates/datasource_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  content = content.replaceAll('feature_name', featureName);
  featureName = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureName);

  print('DataSource template generated successfully');
  return content;
}

String getRepositoryImplTemplate(String featureName) {
  // read content file from cli_tool/templates/repository_impl_template.dart
  String content = File('templates/repository_impl_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  String featureNameCamelCase = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureNameCamelCase);
  content = content.replaceAll('feature_name', featureName);

  print('RepositoryImpl template generated successfully');
  return content;
}

String getScreenTemplate(String featureName) {
  // read content file from cli_tool/templates/screen_template.dart
  String content = File('templates/screen_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  String featureNameCamelCase = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureNameCamelCase);

  print('Screen template generated successfully');
  return content;
}

String getProviderTemplate(String featureName) {
  // read content file from cli_tool/templates/provider_template.dart
  String content = File('templates/provider_template.dart').readAsStringSync();
  // replace all placeholder with featureName
  // snake_case to CamelCase
  String featureNameCamelCase = featureName.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
  content = content.replaceAll('FeatureName', featureNameCamelCase);

  print('Provider template generated successfully');
  return content;
}
