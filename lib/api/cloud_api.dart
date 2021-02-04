import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

class CloudApi {
  static final CloudApi _cloudApi = CloudApi._internal();

  factory CloudApi() => _cloudApi;

  CloudApi._internal() {
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  final _dio =
      Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3333', connectTimeout: 3000));
  final _cookieJar = CookieJar();

  ///[phone] : 手机号
  ///[password] : 密码
  ///[countryCode] : 国家码，用于国外手机号登录，例如美国传入：1
  ///[md5Password] : md5加密后的密码,传入后 password 将失效
  Future<Response> loginCellPhone(
      {@required int phone,
      @required String password,
      int countryCode,
      String md5Password}) async {
    return await _dio.post('/login/cellphone', data: {
      'phone': phone,
      'password': password,
      'countrycode': countryCode,
      'md5_password': md5Password
    });
  }

  ///[email] : 163网易邮箱
  ///[password] : 密码
  ///[md5Password] : md5加密后的密码,传入后 password 将失效
  Future<Response> login(
      {@required String email,
      @required String password,
      String md5Password}) async {
    return _dio.post('login', data: {
      'email': email,
      'password': password,
      'md5_password': md5Password
    });
  }

  ///调用此接口可生成一个key
  Future<Response> loginQrKey() async {
    var response = _dio.get('/login/qr/key');
    return response;
  }

  ///[key]由[loginQrKey]生成
  ///[qrImage]传入后会额外返回二维码图片base64编码
  Future<Response> loginQrCreate({@required String key, String qrImage}) async {
    return _dio.get('/login/qr/create',
        queryParameters: {'key': key, 'qrimg': qrImage});
  }

  ///[key]由[loginQrKey]生成
  ///轮询此接口可获取二维码扫码状态,
  ///800为二维码过期,801为等待扫码,
  ///802为待确认,803为授权登录成功(803状态码下会返回cookies)
  Future<Response> loginQrCheck({@required String key}) async {
    return _dio.get('/login/qr/check', queryParameters: {'key': key});
  }

  ///调用此接口 , 可刷新登录状态
  Future<Response> loginRefresh() async {
    return _dio.get('/login/refresh');
  }

  ///[phone] : 手机号码
  ///[ctcode] : 国家区号,默认86即中国
  ///调用此接口 ,传入手机号码, 可发送验证码
  Future<Response> captchaSend({@required int phone, int ctcode = 86}) async {
    return _dio.get('/captcha/send',
        queryParameters: {'phone': phone, 'ctcode': ctcode});
  }

  ///[phone] : 手机号码
  ///[captcha] : 验证码
  ///[ctcode] : 国家区号,默认86即中国
  ///调用此接口 ,传入手机号码和验证码, 可校验验证码是否正确
  Future<Response> captchaVerify(
      {@required int phone, @required int captcha, int ctcode = 86}) async {
    return _dio.get('/captcha/verify', queryParameters: {
      'phone': phone,
      'captcha': captcha,
      'ctcode': ctcode
    });
  }

  ///[captcha] : 验证码
  ///[phone] : 手机号码
  ///[password] : 密码
  ///[nickname] : 昵称
  ///调用此接口 ,传入手机号码和验证码,密码,昵称, 可注册网易云音乐账号(同时可修改密码)
  Future<Response> registerCellphone(
      {@required int captcha,
      @required int phone,
      @required String password,
      @required String nickname}) async {
    return _dio.post('/register/cellphone', queryParameters: {
      'captcha': captcha,
      'phone': phone,
      'password': password,
      'nickname': nickname
    });
  }

  ///[nickname]昵称
  ///刚注册的账号(需登录),调用此接口 ,可初始化昵称
  Future<Response> activeInitProfile({@required String nickname}) async {
    return _dio
        .get('/active/init/profile', queryParameters: {'nickname': nickname});
  }

  ///[oldCaptcha] : 原手机验证码
  ///[captcha] :新手机验证码
  ///[phone] : 手机号码
  ///[ctcode] : 国家区号,默认86即中国
  ///调用此接口 ,可更换绑定手机(流程:先发送验证码到原手机号码,
  ///再发送验证码到新手机号码然后再调用此接口)
  Future<Response> rebind(
      {@required int oldCaptcha,
      @required int captcha,
      @required int phone,
      ctcode = 86}) async {
    return _dio.get('/rebind', queryParameters: {
      'oldcaptcha': oldCaptcha,
      'captcha': captcha,
      'phone': phone,
      'ctcode': ctcode
    });
  }

  ///调用此接口 , 可退出登录
  Future<Response> logout() async {
    return _dio.get('/logout');
  }

  ///[uid] : 用户 id
  ///登录后调用此接口 , 传入用户 id, 可以获取用户详情
  Future<Response> loginStatus({@required int uid}) async {
    return _dio.get('/user/detail', queryParameters: {'uid': uid});
  }

  ///登录后调用此接口 ,可获取用户账号信息
  Future<Response> userAccount() async {
    return _dio.get('/user/account');
  }

  ///登录后调用此接口 , 可以获取用户信息
  Future<Response> userSubcount() async {
    return _dio.get('/user/subcount');
  }

  ///登录后调用此接口 , 可以获取用户等级信息,包含当前登录天数,听歌次数,
  ///下一等级需要的登录天数和听歌次数,当前等级进度,
  ///对应 https://music.163.com/#/user/level
  Future<Response> userLevel() async {
    return _dio.get('/user/level');
  }

  ///[uid] : 用户 id
  ///登录后调用此接口 , 可以获取用户绑定信息
  Future<Response> userBinding({@required int uid}) async {
    return _dio.get('/user/binding');
  }

  ///[phone] : 手机号码
  ///[oldCaptcha] : 原手机号码的验证码
  ///[captcha] : 新手机号码的验证码
  ///登录后调用此接口 , 可以更换绑定手机
  Future<Response> userReplacePhone(
      {@required int phone,
      @required int oldCaptcha,
      @required int captcha,
      int countryCode = 86}) async {
    return _dio.get('/user/replacephone', queryParameters: {
      'phone': phone,
      'oldcaptcha': oldCaptcha,
      'captcha': captcha,
      'countrycode': countryCode,
    });
  }

  ///[gender] : 性别 0:保密 1:男性 2:女性
  ///[birthday] : 出生日期,时间戳 unix timestamp
  ///[nickname] : 用户昵称
  ///[province] : 省份id
  ///[city] : 城市id
  ///[signature] : 用户签名
  ///登录后调用此接口 , 传入相关信息,可以更新用户信息
  Future<Response> userUpdate(
      {@required int gender,
      @required int birthday,
      @required String nickname,
      @required int province,
      @required int city,
      @required String signature}) async {
    return _dio.get('/user/update', queryParameters: {
      'gender': gender,
      'birthday': birthday,
      'nickname': nickname,
      'province': province,
      'city': city,
      'signature': signature,
    });
  }

  ///TODO
  ///[imgSize] : 图片尺寸,默认为300
  ///[imgX] : 水平裁剪偏移,方形图片可不传,默认为0
  ///[imgY] : 垂直裁剪偏移,方形图片可不传,默认为0
  Future<Response> avatarUpload(
      {@required avatar, int imgSize = 300, int imgX = 0, int imgY = 0}) async {
    return _dio.post(
      '/avatar/upload',
      data: avatar,
      queryParameters: {'imgSize': imgSize, 'imgX': imgX, 'imgY': imgY},
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  ///调用此接口,可获取国家编码列表
  Future<Response> countriesCodeList() async {
    return _dio.get('/countries/code/list');
  }

  ///[uid] : 用户 id
  ///[limit] : 返回数量,默认为 30
  ///[offset] : 偏移数量,用于分页,如 :( 页数 -1)*30, 其中30为limit的值,默认为0
  ///登录后调用此接口 , 传入用户 id, 可以获取用户歌单
  Future<Response> userPlaylist(
      {@required int uid, int limit = 30, int offset = 0}) async {
    return _dio.get('/user/playlist',
        queryParameters: {'uid': uid, 'limit': limit, 'offset': offset});
  }

  ///更新歌单
  ///
  ///搜索
  Future<Response> search(
      {@required String keywords,
      int limit = 30,
      int offset = 0,
      int type = 1}) async {
    return await _dio.get('/cloudsearch', queryParameters: {
      'keywords': keywords,
      'limit': limit,
      'offset': offset,
      'type': type,
    });
  }
}
