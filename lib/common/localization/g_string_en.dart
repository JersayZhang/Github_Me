import 'package:github_me/common/localization/g_string_base.dart';

class GStringEn extends GStringBase {
  @override
  String app_name = "Github_Me";

  @override
  String home_dynamic = "Dynamic";

  @override
  String home_my = "Trend";

  @override
  String home_trend = "My";

  @override
  String network_error_401 = "Http 401";
  @override
  String network_error_403 = "Http 403";
  @override
  String network_error_404 = "Http 404";
  @override
  String network_error_422 = "Request Body Error，Please Check Github ClientId or Account/PW";
  @override
  String network_error_timeout = "Http timeout";
  @override
  String network_error_unknown = "Http unknown error";
  @override
  String network_error = "network error";
  @override
  String github_refused =
      "Github Api Error[OS Error: Connection refused]. Please switch networks or try again later ";
}
