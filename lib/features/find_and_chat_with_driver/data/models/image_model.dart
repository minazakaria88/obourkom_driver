class ImageModel
{
  String ? token;
  ImageModel.fromJson(Map<String,dynamic> json)
  {
    token = json['token'];
  }
}