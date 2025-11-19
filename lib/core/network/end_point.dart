class EndPoints
{
  static const baseUrl = 'https://3borkom.elnoorphp.com/';
  //login
  static const login='api/login';
  static const verifyOtp='api/verify-code-login';
  static const resendOtp='api/resendCode';

  //register
  static const register='api/register';
  static const resendOtpRegister='api/verify-resendCodeRegister';
  static const verifyOtpRegister='api/verify-code';

  //order
  static const orders='api/orders';


  //locations

  static const addresses='api/addresses';

  //upload image

  static const uploadImage='api/media/upload';



  static const updateProfile = 'api/update/profile';
  static const profile = 'api/profile';

  static const notification='api/notifications';
  static const seenNotifications='api/notifications/seen';
  static const faq='api/questions';
  static const cancelOrder='cancelOrder';
  static const categories='api/categories';
  static const trucks='api/truck';
  static const trucksSize='api/truck-size';
  static const truckType='api/truck-type';
  static const truckBrand='api/brand-model';   //brand
  static const truckModel='api/brands/7/brand_models';   //model

  static const cars='api/cars';

  static const slider='api/sliders';

  static const aboutUs='api/pages';


}