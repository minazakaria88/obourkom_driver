
import '../../../otp/data/models/user_model.dart';

class CachedUserModel
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  CachedUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  CachedUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }



  CachedUserModel.fromUserModel(User user)
  {
    id=user.id;
    name=user.name;
    email=user.email;
    phone=user.phone;
    image=user.avatar;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    if (image != null) {
      data['image'] = image;
    }
    return data;
  }
}