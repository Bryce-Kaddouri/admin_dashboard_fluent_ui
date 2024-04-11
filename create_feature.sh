# This file is script to create a new feature in the project
# Usage: ./create_feature.sh <feature_name>

# Check if the feature name is provided as an argument or not
if [ -z "$1" ]
then
    echo "Please provide the feature name as an argument"
    exit 1
fi

# Create a new feature folder in the project (eg: lib/src/features/<feature_name>)
# Here you have the structure of the feature folder
# - <feature_name>
#   - business
#     - repository
#       - <feature_name>_repository.dart
#     - usecase
#     - param
#   - data
#     - datasource
#       - <feature_name>_datasource.dart
#     - model
#       - <feature_name>_model.dart
#     - repository
#       - <feature_name>_repository_impl.dart
#   - presentation
#     - provider
#       - <feature_name>_provider.dart
#     - screen
#       - <feature_name>_screen.dart
#     - widget

mkdir -p lib/src/feature/$1/business/repository
mkdir -p lib/src/feature/$1/business/usecase
mkdir -p lib/src/feature/$1/business/param
mkdir -p lib/src/feature/$1/data/datasource
mkdir -p lib/src/feature/$1/data/model
mkdir -p lib/src/feature/$1/data/repository
mkdir -p lib/src/feature/$1/presentation/provider
mkdir -p lib/src/feature/$1/presentation/screen
mkdir -p lib/src/feature/$1/presentation/widget

touch lib/src/feature/$1/business/repository/$1_repository.dart
touch lib/src/feature/$1/data/datasource/$1_datasource.dart
touch lib/src/feature/$1/data/model/$1_model.dart
touch lib/src/feature/$1/data/repository/$1_repository_impl.dart
touch lib/src/feature/$1/presentation/provider/$1_provider.dart
touch lib/src/feature/$1/presentation/screen/$1_screen.dart

echo "Feature $1 created successfully"
exit 0

# End of file


