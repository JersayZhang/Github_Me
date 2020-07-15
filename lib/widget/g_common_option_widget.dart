import 'package:flutter/material.dart';
import 'package:github_me/common/localization/default_localization.dart';
import 'package:github_me/common/style/g_style.dart';
import 'package:github_me/common/utils/common_utils.dart';
import 'package:share/share.dart';

class GCommonOptionWidget extends StatelessWidget {
  final List<GOptionModel> otherList;
  final String url;

  GCommonOptionWidget({this.otherList, String url})
      : this.url = (url == null) ? GConstant.app_default_share_url : url;

  _renderHeaderPopItem(List<GOptionModel> list) {
    return new PopupMenuButton<GOptionModel>(
      child: new Icon(GIcons.MORE),
      onSelected: (model) {
        model.selected(model);
      },
      itemBuilder: (BuildContext context) {
        return _renderHeaderPopItemChild(list);
      },
    );
  }

  _renderHeaderPopItemChild(List<GOptionModel> data) {
    List<PopupMenuEntry<GOptionModel>> list = new List();
    for (GOptionModel item in data) {
      list.add(PopupMenuItem<GOptionModel>(
        value: item,
        child: new Text(item.name),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<GOptionModel> constList = [
      new GOptionModel(
          GLocalizations.i18n(context).option_web, GLocalizations.i18n(context).option_web,
          (model) {
        CommonUtils.launchOutUrl(url, context);
      }),
      new GOptionModel(
          GLocalizations.i18n(context).option_copy, GLocalizations.i18n(context).option_copy,
          (model) {
        CommonUtils.copy(url ?? "", context);
      }),
      new GOptionModel(
          GLocalizations.i18n(context).option_share, GLocalizations.i18n(context).option_share,
          (model) {
        Share.share(GLocalizations.i18n(context).option_share_title + url ?? "");
      }),
    ];
    var list = [...constList, ...?otherList];
    return _renderHeaderPopItem(list);
  }
}

class GOptionModel {
  final String name;
  final String value;
  final PopupMenuItemSelected<GOptionModel> selected;

  GOptionModel(this.name, this.value, this.selected);
}
