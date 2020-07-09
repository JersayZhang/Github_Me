import 'package:github_me/common/localization/g_string_base.dart';

class GStringZh extends GStringBase {
  @override
  String app_name = "Github_Me";

  @override
  String home_dynamic = "动态";

  @override
  String home_my = "趋势";

  @override
  String home_trend = "我的";

  @override
  String network_error_401 = "[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]";
  @override
  String network_error_403 = "403权限错误";
  @override
  String network_error_404 = "404错误";
  @override
  String network_error_422 = "请求实体异常，请确保 Github ClientId 、账号秘密等信息正确。";
  @override
  String network_error_timeout = "请求超时";
  @override
  String network_error_unknown = "其他异常";
  @override
  String network_error = "网络错误";
  @override
  String github_refused = "Github Api 出现异常[Connection refused]，建议换个网络环境或者稍后再试";
}
