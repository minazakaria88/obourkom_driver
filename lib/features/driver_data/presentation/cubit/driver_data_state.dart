part of 'driver_data_cubit.dart';


@immutable
class DriverDataState extends Equatable {
  final CategoriesModel? categoriesModel;
  final String? errorMessage;

  const DriverDataState({this.categoriesModel, this.errorMessage});

  DriverDataState copyWith({
    CategoriesModel? categoriesModel,
    String? errorMessage,
  }) {
    return DriverDataState(
      categoriesModel: categoriesModel ?? this.categoriesModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [categoriesModel, errorMessage];
}
