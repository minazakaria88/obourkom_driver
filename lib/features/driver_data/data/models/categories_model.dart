class CategoriesModel {
  List<CategoryModel>? data;


  CategoriesModel({this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(CategoryModel.fromJson(v));
      });
      data!.add(CategoryModel(name: 'نقل آخر',id: -1));
    }
  }

  CategoriesModel copyWith({List<CategoryModel>? data}) {
    return CategoriesModel(
      data: data ?? this.data,
    );
  }

}

class CategoryModel {
  int? id;
  String? name;
  String? image;
  bool? isSelected = false;
  List<TruckModel>? trucks;

  CategoryModel({this.id, this.name, this.image, this.trucks});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['trucks'] != null) {
      trucks = <TruckModel>[];
      json['trucks'].forEach((v) {
        trucks!.add(TruckModel.fromJson(v));
      });
    }
  }
}

class TruckModel {
  int? id;
  String? name;
  String? image;

  TruckModel(
      {this.name,this.image}
      );

  TruckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}


