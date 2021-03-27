import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'settings.dart';


class SettingsScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;
  final Color? appBarBackgroundColor;

  SettingsScreen({
    required this.title,
    required this.children,
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
    this.appBarBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return _ConfirmableScreen(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarBackgroundColor,
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: children.length,
          itemBuilder: (BuildContext context, int index) {
            return children[index];
          },
        ),
      ),
      confirmText: confirmText,
      confirmModalTitle: confirmModalTitle,
      confirmModalCancelCaption: confirmModalCancelCaption,
      confirmModalConfirmCaption: confirmModalConfirmCaption,
    );
  }
}

class SettingsToggleScreen extends StatelessWidget {
  final String settingKey;
  final bool defaultValue;
  final String title;
  final String subtitle;
  final String subtitleIfOff;
  final List<Widget> children;
  final List<Widget>? childrenIfOff;
  final String? confirmText;
  final String? confirmTextToEnable;
  final String? confirmTextToDisable;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  SettingsToggleScreen({
    required this.title,
    required this.settingKey,
    required this.children,
    this.childrenIfOff,
    this.defaultValue = false,
    this.subtitle = "On",
    this.subtitleIfOff = "Off",
    this.confirmText,
    this.confirmTextToEnable,
    this.confirmTextToDisable,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Settings().onBoolChanged(
      settingKey: settingKey,
      defaultValue: defaultValue,
      childBuilder: (BuildContext context, bool value) {
        return _ConfirmableScreen(
          child: SettingsScreen(
            title: title,
            children: _buildChildren(
              value,
              value == false && childrenIfOff != null
                  ? childrenIfOff!
                  : children,
            ),
            confirmText: confirmText,
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(bool value, List<Widget> children) {
    List<Widget> elements = [
      SwitchSettingsTile(
        settingKey: settingKey,
        title:
        value == false ? subtitleIfOff : subtitle,
        defaultValue: defaultValue,
        confirmText: confirmText,
        confirmTextToEnable: confirmTextToEnable,
        confirmTextToDisable: confirmTextToDisable,
        confirmModalTitle: confirmModalTitle,
        confirmModalCancelCaption: confirmModalCancelCaption,
        confirmModalConfirmCaption: confirmModalConfirmCaption,
      ),
    ];
    elements.addAll(children);
    return elements;
  }
}

class SettingsTileGroup extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final String? visibleIfKey;
  final bool visibleByDefault;

  SettingsTileGroup({
    required this.title,
    this.subtitle,
    required this.children,
    this.visibleIfKey,
    this.visibleByDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    if (visibleIfKey == null) {
      return _buildChild(context);
    }
    return Settings().onBoolChanged(
      settingKey: visibleIfKey,
      defaultValue: visibleByDefault,
      childBuilder: (BuildContext context, bool visible) {
        return visible ? _buildChild(context) : Container();
      },
    );
  }

  Widget _buildChild(BuildContext context) {
    List<Widget> elements = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 22.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];

    if (subtitle != null) {
      elements.addAll([
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Align(alignment: Alignment.centerLeft, child: Text(subtitle!)),
        ),
        _SettingsTileDivider(),
      ]);
    }
    elements.addAll(children);
    return Column(
      children: elements,
    );
  }
}

class _SettingsTile extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Icon? icon;
  final Widget? leading;
  final Widget? widget;
  final Widget? child;
  final Widget? screen;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final Function? onTap;

  _SettingsTile({
    required this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.widget,
    this.child,
    this.screen,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => __SettingsTileState();
}

class __SettingsTileState extends State<_SettingsTile>
    with _Confirmable, _Enableable {
  @override
  void initState() {
    super.initState();
    if (widget.visibleIfKey != null) {
      Future.delayed(Duration.zero, () {
        Settings().pingBool(widget.visibleIfKey!, widget.visibleByDefault);
      });
    }
    if (widget.enabledIfKey != null) {
      Future.delayed(Duration.zero, () {
        Settings().pingBool(widget.enabledIfKey!, widget.visibleByDefault);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visibleIfKey == null) {
      return _wrapEnableable(context)!;
    }
    return Settings().onBoolChanged(
      settingKey: widget.visibleIfKey,
      defaultValue: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool visible) {
        return visible ? _wrapEnableable(context) : Container();
      },
    );
  }

  Widget? _wrapEnableable(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return _buildChild(context, enabled);
      },
    );
  }

  Widget _buildChild(BuildContext context, bool enabled) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: widget.icon ?? widget.leading,
          title: Text(widget.title!),
          subtitle: _buildSubtitle(),
          onTap: _shouldDisableTap(enabled)
              ? null
              : () {
            _handleTap(context);
          },
          trailing: widget.widget,
          enabled: enabled,
        ),
        _SettingsTileDivider(),
      ],
    );
  }

  bool _shouldDisableTap(bool enabled) =>
      (widget.screen == null &&
          widget.widget == null &&
          widget.onTap == null) ||
          enabled == false;

  Widget? _buildSubtitle() {
    Widget? subtitleWidget =
    widget.subtitle != null ? Text(widget.subtitle!) : null;
    if (widget.child == null) {
      return subtitleWidget;
    }
    if (subtitleWidget == null) {
      return widget.child;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        subtitleWidget,
        widget.child!,
      ],
    );
  }

  _handleTap(BuildContext context) {
    if (widget.screen != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => widget.screen!),
      );
    } else {
      widget.onTap?.call();
    }
  }
}

class ExpansionSettingsTile extends StatelessWidget {
  final String title;
  final Icon? icon;
  final List<Widget> children;
  final String? visibleIfKey;
  final bool visibleByDefault;
  final bool initiallyExpanded;

  ExpansionSettingsTile({
    required this.title,
    this.icon,
    required this.children,
    this.initiallyExpanded = false,
    this.visibleIfKey,
    this.visibleByDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    if (visibleIfKey == null) {
      return _buildChild(context);
    }
    return Settings().onBoolChanged(
      settingKey: visibleIfKey,
      defaultValue: visibleByDefault,
      childBuilder: (BuildContext context, bool visible) {
        return visible ? _buildChild(context) : Container();
      },
    );
  }

  Widget _buildChild(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: children,
      leading: icon,
      initiallyExpanded: initiallyExpanded,
    );
  }
}

class _SettingsTileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.0,
    );
  }
}

class SimpleSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Icon? icon;
  final Widget? screen;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;

  SimpleSettingsTile({
    required this.title,
    this.subtitle,
    this.icon,
    this.screen,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      title: title,
      subtitle: subtitle,
      icon: icon,
      screen: screen,
      visibleIfKey: visibleIfKey,
      enabledIfKey: enabledIfKey,
      visibleByDefault: visibleByDefault,
    );
  }
}

class CheckboxSettingsTile extends StatefulWidget {
  final String settingKey;
  final String title;
  final bool defaultValue;
  final String? subtitle;
  final String? subtitleIfOff;
  final Icon? icon;
  final Widget? screen;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String? confirmText;
  final String? confirmTextToEnable;
  final String? confirmTextToDisable;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  CheckboxSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue = false,
    this.subtitle,
    this.subtitleIfOff,
    this.icon,
    this.screen,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.confirmText,
    this.confirmTextToEnable,
    this.confirmTextToDisable,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  State<StatefulWidget> createState() => _CheckboxSettingsTileState();
}

class _CheckboxSettingsTileState extends State<CheckboxSettingsTile>
    with _Confirmable, _Enableable {
  bool? value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
    Future.delayed(Duration.zero, () {
      Settings().pingBool(widget.settingKey, widget.defaultValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return Settings().onBoolChanged(
          settingKey: widget.settingKey,
          defaultValue: widget.defaultValue,
          childBuilder: (BuildContext context, bool value) {
            return _SettingsTile(
              title: widget.title,
              subtitle: value == true || widget.subtitleIfOff == null
                  ? widget.subtitle
                  : widget.subtitleIfOff,
              icon: widget.icon,
              screen: widget.screen,
              visibleIfKey: widget.visibleIfKey,
              enabledIfKey: widget.enabledIfKey,
              visibleByDefault: widget.visibleByDefault,
              widget: _SettingsCheckbox(
                value: value,
                onChanged: _onChanged,
                enabled: enabled,
              ),
            );
          },
        );
      },
    );
  }

  void _onChanged(bool? newValue) {
    confirm(
      context: context,
      oldValue: value,
      newValue: newValue,
      onConfirm: () {
        setState(() {
          value = newValue;
          Settings().save(widget.settingKey, value);
        });
      },
      confirmText: widget.confirmText,
      confirmTextToEnable: widget.confirmTextToEnable,
      confirmTextToDisable: widget.confirmTextToDisable,
      confirmModalTitle: widget.confirmModalTitle,
      confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      confirmModalCancelCaption: widget.confirmModalCancelCaption,
    );
  }
}

class SwitchSettingsTile extends StatefulWidget {
  final String settingKey;
  final bool defaultValue;
  final String title;
  final String? subtitle;
  final String? subtitleIfOff;
  final Icon? icon;
  final Widget? screen;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String? confirmText;
  final String? confirmTextToEnable;
  final String? confirmTextToDisable;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  SwitchSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue = false,
    this.subtitle,
    this.subtitleIfOff,
    this.icon,
    this.screen,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.confirmText,
    this.confirmTextToEnable,
    this.confirmTextToDisable,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  State<StatefulWidget> createState() => _SwitchSettingsTileState();
}

class _SwitchSettingsTileState extends State<SwitchSettingsTile>
    with _Confirmable, _Enableable {
  bool? value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
    Future.delayed(Duration.zero, () {
      Settings().pingBool(widget.settingKey, widget.defaultValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return Settings().onBoolChanged(
          settingKey: widget.settingKey,
          defaultValue: widget.defaultValue,
          childBuilder: (BuildContext context, bool value) {
            return _SettingsTile(
              title: widget.title,
              subtitle: value == true || widget.subtitleIfOff == null
                  ? widget.subtitle
                  : widget.subtitleIfOff,
              icon: widget.icon,
              screen: widget.screen,
              visibleIfKey: widget.visibleIfKey,
              visibleByDefault: widget.visibleByDefault,
              widget: _SettingsSwitch(
                value: value,
                onChanged: _onChanged,
                enabled: enabled,
              ),
            );
          },
        );
      },
    );
  }

  void _onChanged(bool newValue, [update = true]) {
    confirm(
      context: context,
      oldValue: value,
      newValue: newValue,
      onConfirm: () {
        if (update) {
          setState(() {
            _change(newValue);
          });
        } else {
          _change(newValue);
        }
      },
      confirmText: widget.confirmText,
      confirmTextToEnable: widget.confirmTextToEnable,
      confirmTextToDisable: widget.confirmTextToDisable,
      confirmModalTitle: widget.confirmModalTitle,
      confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      confirmModalCancelCaption: widget.confirmModalCancelCaption,
    );
  }

  void _change(bool newValue) {
    value = newValue;
    Settings().save(widget.settingKey, value);
  }
}

class RadioSettingsTile extends StatefulWidget {
  final String settingKey;
  final String title;
  final Map<String, String> values;
  final defaultKey;
  final String? subtitle;
  final String? subtitleIfOff;
  final Icon? icon;
  final Widget? screen;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final bool expandable;
  final bool initiallyExpanded;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  RadioSettingsTile({
    required this.settingKey,
    required this.title,
    required this.values,
    this.defaultKey,
    this.subtitle,
    this.subtitleIfOff,
    this.icon,
    this.screen,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.expandable = false,
    this.initiallyExpanded = false,
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  State<StatefulWidget> createState() => _RadioSettingsTileState();
}

class _RadioSettingsTileState extends State<RadioSettingsTile>
    with _Confirmable, _Enableable {
  String? selectedKey;
  String? selectedTitle;

  @override
  void initState() {
    super.initState();
    selectedKey = widget.defaultKey;
    Future.delayed(Duration.zero, () {
      Settings().pingString(widget.settingKey, widget.defaultKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return Settings().onStringChanged(
          settingKey: widget.settingKey,
          defaultValue: selectedKey,
          childBuilder: (BuildContext context, String value) {
            _change(value);
            List<Widget> elements = <Widget>[];
            elements.add(_buildTile(value, enabled));
            if (widget.values.isNotEmpty &&
                !widget.expandable) {
              elements.addAll(_buildChildren(value, enabled));
            }
            return Column(children: elements);
          },
        );
      },
    );
  }

  Widget _buildTile(String groupValue, bool enabled) {
    String? subtitle = selectedTitle != null
        ? widget.subtitle ?? selectedTitle
        : widget.subtitleIfOff;
    return widget.expandable
        ? ExpansionSettingsTile(
      title: widget.title,
      icon: widget.icon,
      visibleIfKey: widget.visibleIfKey,
      visibleByDefault: widget.visibleByDefault,
      initiallyExpanded: widget.initiallyExpanded,
      children: _buildChildren(groupValue, enabled),
    )
        : _SettingsTile(
      title: widget.title,
      subtitle: subtitle,
      icon: widget.icon,
      screen: widget.screen,
      visibleIfKey: widget.visibleIfKey,
      visibleByDefault: widget.visibleByDefault,
    );
  }

  List<Widget> _buildChildren(String groupValue, bool enabled) {
    List<Widget> elements = <Widget>[];
    widget.values.forEach((optionKey, optionName) {
      elements.add(_SimpleRadioSettingsTile(
        title: optionName,
        value: optionKey,
        groupValue: groupValue,
        onChanged: _onChanged,
        enabled: enabled,
      ));
    });
    return elements;
  }

  String? _getNameByKey(String? key) =>
      widget.values.containsKey(key) ? widget.values[key] : null;

  void _onChanged(String? newKey) {
    confirm(
      context: context,
      oldValue: selectedKey,
      newValue: newKey,
      onConfirm: () {
        setState(() {
          _change(newKey);
          Settings().save(widget.settingKey, selectedKey);
        });
      },
      confirmText: widget.confirmText,
      confirmModalTitle: widget.confirmModalTitle,
      confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      confirmModalCancelCaption: widget.confirmModalCancelCaption,
    );
  }

  void _change(String? newKey) {
    selectedKey = newKey;
    selectedTitle = _getNameByKey(selectedKey);
  }
}

class _SimpleRadioSettingsTile extends StatelessWidget {
  final String? title;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  _SimpleRadioSettingsTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsTile(
      title: title,
      widget: _SettingsRadio(
        groupValue: groupValue,
        value: value,
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }
}

class SliderSettingsTile extends StatefulWidget {
  final String settingKey;
  final String title;
  final double defaultValue;
  final double minValue;
  final double maxValue;
  final double step;
  final String? subtitle;
  final Icon? icon;
  final Icon? minIcon;
  final Icon? maxIcon;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String? confirmText;
  final String? confirmTextToEnable;
  final String? confirmTextToDisable;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  SliderSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue = 0.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.step = 1.0,
    this.subtitle,
    this.icon,
    this.minIcon,
    this.maxIcon,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.confirmText,
    this.confirmTextToEnable,
    this.confirmTextToDisable,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  State<StatefulWidget> createState() => _SliderSettingsTileState();
}

class _SliderSettingsTileState extends State<SliderSettingsTile>
    with _Confirmable, _Enableable {
  double? value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
    Future.delayed(Duration.zero, () {
      Settings().pingDouble(widget.settingKey, widget.defaultValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return Settings().onDoubleChanged(
          settingKey: widget.settingKey,
          defaultValue: value,
          childBuilder: (BuildContext context, double value) {
            return _SettingsTile(
              title: widget.title,
              subtitle: widget.subtitle,
              icon: widget.icon,
              visibleIfKey: widget.visibleIfKey,
              visibleByDefault: widget.visibleByDefault,
              child: _SettingsSlider(
                value: value,
                min: widget.minValue,
                max: widget.maxValue,
                step: widget.step,
                onChanged: _onChanged,
                enabled: enabled,
                leading: widget.minIcon ?? Container(),
                trailing: widget.maxIcon ?? Text(_getStringValue()),
              ),
            );
          },
        );
      },
    );
  }

  void _onChanged(double newValue) {
    confirm(
      context: context,
      oldValue: value,
      newValue: newValue,
      onConfirm: () {
        setState(() {
          value = newValue;
          Settings().save(widget.settingKey, value);
        });
      },
      confirmText: widget.confirmText,
      confirmTextToEnable: widget.confirmTextToEnable,
      confirmTextToDisable: widget.confirmTextToDisable,
      confirmModalTitle: widget.confirmModalTitle,
      confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      confirmModalCancelCaption: widget.confirmModalCancelCaption,
    );
  }

  String _getStringValue() {
    int n = 0;
    while (1 ~/ widget.step > math.pow(10, n)) {
      n++;
    }
    return value!.toStringAsFixed(n);
  }
}

class _ModalSettingsTile extends StatefulWidget {
  final String settingKey;
  final String? defaultValue;
  final String title;
  final String? subtitle;
  final Icon? icon;
  final Widget? leading;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final Function valueToTitle;
  final Function buildChild;
  final bool refreshStateOnChange;
  final ValueChanged<String>? onChanged;
  final String cancelCaption;
  final String okCaption;
  final String? confirmText;
  final String? confirmTextToEnable;
  final String? confirmTextToDisable;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;
  final Function? valueMap;
  final obfuscateSubtitle;

  _ModalSettingsTile({
    required this.settingKey,
    this.defaultValue,
    required this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    required this.valueToTitle,
    required this.buildChild,
    this.refreshStateOnChange = true,
    this.onChanged,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    this.confirmText,
    this.confirmTextToEnable,
    this.confirmTextToDisable,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
    this.valueMap,
    this.obfuscateSubtitle = false,
  });

  @override
  __ModalSettingsTileState createState() => __ModalSettingsTileState();
}

class __ModalSettingsTileState extends State<_ModalSettingsTile>
    with _Confirmable, _Enableable {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.defaultValue;
    Future.delayed(Duration.zero, () {
      Settings().pingString(widget.settingKey, widget.defaultValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return wrapEnableable(
      context: context,
      enabledIfKey: widget.enabledIfKey,
      visibleByDefault: widget.visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return Settings().onStringChanged(
          settingKey: widget.settingKey,
          defaultValue: widget.defaultValue,
          childBuilder: (BuildContext context, String value) {
            return _SettingsTile(
              title: widget.title,
              subtitle: _getSubtitle(value),
              icon: widget.icon,
              leading: widget.leading,
              visibleIfKey: widget.visibleIfKey,
              enabledIfKey: widget.enabledIfKey,
              visibleByDefault: widget.visibleByDefault,
              onTap: enabled
                  ? () {
                _openModal(context, value);
              }
                  : null,
            );
          },
        );
      },
    );
  }

  String? _getSubtitle(String value) {
    return widget.valueToTitle(value) != null
        ? widget.subtitle ??
        (!widget.obfuscateSubtitle
            ? widget.valueToTitle(value)
            : value.length > 0
            ? widget.valueToTitle('●' * value.length)
            : "Not Set")
        : null;
  }

  void _onChanged(String newValue) {
    confirm(
      context: context,
      oldValue: value,
      newValue: newValue,
      onConfirm: () {
        setState(() {
          value =
          widget.valueMap != null ? widget.valueMap!(newValue) : newValue;
          Settings().save(widget.settingKey, value);
          widget.onChanged?.call(value!);
        });
      },
      confirmText: widget.confirmText,
      confirmTextToEnable: widget.confirmTextToEnable,
      confirmTextToDisable: widget.confirmTextToDisable,
      confirmModalTitle: widget.confirmModalTitle,
      confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      confirmModalCancelCaption: widget.confirmModalCancelCaption,
    );
  }

  void _openModal(BuildContext context, String value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _SettingsModal(
          title: widget.title,
          onSelected: _onChanged,
          initialValue: value,
          buildChild: widget.buildChild,
          refreshStateOnChange: widget.refreshStateOnChange,
          cancelCaption: widget.cancelCaption,
          okCaption: widget.okCaption,
        );
      },
    );
  }
}

class _SettingsModal extends StatefulWidget {
  final String title;
  final Function buildChild;
  final String initialValue;
  final ValueChanged<String> onSelected;
  final bool? refreshStateOnChange;
  final String cancelCaption;
  final String okCaption;

  _SettingsModal({
    required this.title,
    required this.buildChild,
    required this.initialValue,
    required this.onSelected,
    this.refreshStateOnChange,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
  });

  @override
  __SettingsModalState createState() => __SettingsModalState();
}

class __SettingsModalState extends State<_SettingsModal> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.buildChild(value, _onChanged),
      actions: <Widget>[
        TextButton(
          child: Text(
            widget.cancelCaption,
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(widget.okCaption),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSelected(value);
          },
        ),
      ],
    );
  }

  void _onChanged(String newValue) {
    if (widget.refreshStateOnChange!) {
      setState(() {
        _handleChange(newValue);
      });
    } else {
      _handleChange(newValue);
    }
  }

  void _handleChange(String newValue) {
    value = newValue;
  }
}

class RadioPickerSettingsTile extends StatelessWidget {
  final String settingKey;
  final String title;
  final String? subtitle;
  final Map<String, String> values;
  final String? defaultKey;
  final Icon? icon;
  final String cancelCaption;
  final String okCaption;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;

  RadioPickerSettingsTile({
    required this.settingKey,
    required this.title,
    required this.values,
    this.defaultKey,
    this.subtitle,
    this.icon,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    return _ModalSettingsTile(
      settingKey: settingKey,
      title: title,
      subtitle: subtitle,
      icon: icon,
      defaultValue: defaultKey,
      valueToTitle: (String key) => values[key],
      visibleIfKey: visibleIfKey,
      enabledIfKey: enabledIfKey,
      visibleByDefault: visibleByDefault,
      buildChild: (String value, Function(String?) onChanged) {
        // TODO: Scroll to the selected value.
        return Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            //controller: scrollController,
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              String key = values.keys.toList()[index];
              return _SimpleRadioSettingsTile(
                title: values[key],
                value: key,
                groupValue: value,
                onChanged: onChanged,
                enabled: true,
              );
            },
          ),
        );
      },
      cancelCaption: cancelCaption,
      okCaption: okCaption,
    );
  }
}


class TextFieldModalSettingsTile extends StatelessWidget {
  final String settingKey;
  final String title;
  final String? subtitle;
  final String? defaultValue;
  final Icon? icon;
  final String cancelCaption;
  final String okCaption;
  final TextInputType? keyboardType;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final bool obscureText;

  TextFieldModalSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue,
    this.subtitle,
    this.icon,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    this.keyboardType,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return _ModalSettingsTile(
      settingKey: settingKey,
      title: title,
      subtitle: subtitle,
      obfuscateSubtitle: obscureText,
      icon: icon,
      defaultValue: defaultValue,
      valueToTitle: (String key) => key,
      refreshStateOnChange: false,
      visibleIfKey: visibleIfKey,
      enabledIfKey: enabledIfKey,
      visibleByDefault: visibleByDefault,
      buildChild: (String value, Function onChanged) {
        TextEditingController _controller = TextEditingController();
        _controller.text = value;
        _controller.addListener(() {
          onChanged(_controller.text);
        });
        return TextFormField(
          autofocus: true,
          controller: _controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
        );
      },
      cancelCaption: cancelCaption,
      okCaption: okCaption,
    );
  }
}

class _ColorWidget {
  String _valueToTitle(String value) {
    String color = "00000000";
    try {
      color = value.split('0x')[1].split(')')[0];
    } catch (e) {}
    return "0x$color";
  }

  Color _getColorByString(String value) {
    Color color = Colors.black;
    try {
      color = Color(int.parse(value.split('0x')[1].split(')')[0], radix: 16));
    } catch (e) {}
    return color;
  }
}

class _ColorPickerSettingsTile extends StatelessWidget with _ColorWidget {
  final String settingKey;
  final String title;
  final String? subtitle;
  final String? defaultValue;
  final Icon? icon;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String cancelCaption;
  final String okCaption;
  final Function childBuilder;
  final Function valueToTitle;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  _ColorPickerSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue,
    this.subtitle,
    this.icon,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    required this.childBuilder,
    required this.valueToTitle,
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Settings().onStringChanged(
      settingKey: settingKey,
      defaultValue: defaultValue,
      childBuilder: (BuildContext context, String value) {
        Widget leading = Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: _getColorByString(value),
          ),
        );
        return _ModalSettingsTile(
          settingKey: settingKey,
          title: title,
          subtitle: subtitle,
          icon: icon,
          leading: leading,
          defaultValue: defaultValue,
          visibleIfKey: visibleIfKey,
          enabledIfKey: enabledIfKey,
          visibleByDefault: visibleByDefault,
          valueToTitle: valueToTitle,
          valueMap: (String value) => _valueToTitle(value),
          refreshStateOnChange: false,
          buildChild: childBuilder,
          cancelCaption: cancelCaption,
          okCaption: okCaption,
          confirmText: confirmText,
          confirmModalTitle: confirmModalTitle,
          confirmModalConfirmCaption: confirmModalConfirmCaption,
          confirmModalCancelCaption: confirmModalCancelCaption,
        );
      },
    );
  }
}

class SimpleColorPickerSettingsTile extends StatelessWidget with _ColorWidget {
  final String settingKey;
  final String title;
  final String? subtitle;
  final String? defaultValue;
  final Icon? icon;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String cancelCaption;
  final String okCaption;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  SimpleColorPickerSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue,
    this.subtitle,
    this.icon,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Settings().onStringChanged(
      settingKey: settingKey,
      defaultValue: defaultValue,
      childBuilder: (BuildContext context, String value) {
        return _ColorPickerSettingsTile(
          settingKey: settingKey,
          title: title,
          subtitle: subtitle,
          defaultValue: value,
          icon: icon,
          visibleIfKey: visibleIfKey,
          enabledIfKey: enabledIfKey,
          visibleByDefault: visibleByDefault,
          cancelCaption: cancelCaption,
          okCaption: okCaption,
          valueToTitle: (String key) => _valueToTitle(key),
          childBuilder: (String value, Function onChanged) {
            return ColorPicker(
              pickerColor: _getColorByString(value),
              onColorChanged: (Color color) => onChanged(color.toString()),
              pickerAreaHeightPercent: 1.0,
              enableAlpha: true,
            );
          },
          confirmText: confirmText,
          confirmModalTitle: confirmModalTitle,
          confirmModalConfirmCaption: confirmModalConfirmCaption,
          confirmModalCancelCaption: confirmModalCancelCaption,
        );
      },
    );
  }
}

class MaterialColorPickerSettingsTile extends StatelessWidget
    with _ColorWidget {
  final String settingKey;
  final String title;
  final String? subtitle;
  final String? defaultValue;
  final Icon? icon;
  final String? visibleIfKey;
  final String? enabledIfKey;
  final bool visibleByDefault;
  final String cancelCaption;
  final String okCaption;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  MaterialColorPickerSettingsTile({
    required this.settingKey,
    required this.title,
    this.defaultValue,
    this.subtitle,
    this.icon,
    this.visibleIfKey,
    this.enabledIfKey,
    this.visibleByDefault = true,
    this.cancelCaption = "Cancel",
    this.okCaption = "Ok",
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Settings().onStringChanged(
      settingKey: settingKey,
      defaultValue: defaultValue,
      childBuilder: (BuildContext context, String value) {
        return _ColorPickerSettingsTile(
          settingKey: settingKey,
          title: title,
          subtitle: subtitle,
          defaultValue: value,
          icon: icon,
          visibleIfKey: visibleIfKey,
          enabledIfKey: enabledIfKey,
          visibleByDefault: visibleByDefault,
          cancelCaption: cancelCaption,
          okCaption: okCaption,
          valueToTitle: (String key) => _valueToTitle(key),
          childBuilder: (String value, Function onChanged) {
            return BlockPicker(
              pickerColor: _getColorByString(_valueToTitle(value)),
              onColorChanged: (Color color) {
                onChanged(color.toString());
              },
            );
          },
          confirmText: confirmText,
          confirmModalTitle: confirmModalTitle,
          confirmModalConfirmCaption: confirmModalConfirmCaption,
          confirmModalCancelCaption: confirmModalCancelCaption,
        );
      },
    );
  }
}

class SettingsContainer extends StatelessWidget {
  final Widget? child;
  final List<Widget> children;
  final String? visibleIfKey;
  final bool visibleByDefault;

  SettingsContainer({
    this.child,
    this.children = const <Widget>[],
    this.visibleIfKey,
    this.visibleByDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    if (visibleIfKey == null) {
      return _buildChild();
    }
    return Settings().onBoolChanged(
      settingKey: visibleIfKey,
      defaultValue: visibleByDefault,
      childBuilder: (BuildContext context, bool visible) {
        return visible ? _buildChild() : Container();
      },
    );
  }

  Widget _buildChild() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
    );
  }
}

class _SettingsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool enabled;

  _SettingsCheckbox({
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  _SettingsSwitch({
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _SettingsRadio extends StatelessWidget {
  final String groupValue;
  final String value;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  _SettingsRadio({
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Radio(
      groupValue: groupValue,
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _SettingsSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;

  _SettingsSlider({
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
    this.leading,
    this.trailing,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (leading != null) leading!,
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min) ~/ (step),
            onChanged: enabled ? onChanged : null,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _ConfirmableScreen extends StatefulWidget {
  final Widget child;
  final String? confirmText;
  final String? confirmModalTitle;
  final String? confirmModalCancelCaption;
  final String? confirmModalConfirmCaption;

  _ConfirmableScreen({
    required this.child,
    this.confirmText,
    this.confirmModalTitle,
    this.confirmModalCancelCaption,
    this.confirmModalConfirmCaption,
  });

  @override
  __ConfirmableScreenState createState() => __ConfirmableScreenState();
}

class __ConfirmableScreenState extends State<_ConfirmableScreen>
    with _Confirmable {
  @override
  void initState() {
    super.initState();

    // We need to delay the initialization of the Confirm Alert by one frame
    // to be able to use the context.
    Future.delayed(Duration.zero, () {
      confirm(
        context: context,
        onCancel: () {
          Navigator.of(context).pop();
        },
        confirmText: widget.confirmText,
        confirmModalTitle: widget.confirmModalTitle,
        confirmModalCancelCaption: widget.confirmModalCancelCaption,
        confirmModalConfirmCaption: widget.confirmModalConfirmCaption,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _Confirmable {
  confirm({
    required BuildContext context,
    oldValue,
    newValue,
    Function? onConfirm,
    Function? onCancel,
    String? confirmText,
    String? confirmTextToEnable,
    String? confirmTextToDisable,
    String? confirmModalTitle,
    String? confirmModalCancelCaption,
    String? confirmModalConfirmCaption,
  }) {
    if (newValue == false &&
        oldValue != newValue &&
        confirmTextToDisable != null) {
      return _showDialog(
        context: context,
        onCancel: onCancel,
        onConfirm: onConfirm,
        confirmText: confirmTextToDisable,
        confirmModalTitle: confirmModalTitle,
        confirmModalCancelCaption: confirmModalCancelCaption,
        confirmModalConfirmCaption: confirmModalConfirmCaption,
      );
    }
    if (newValue == true &&
        oldValue != newValue &&
        confirmTextToEnable != null) {
      return _showDialog(
        context: context,
        onCancel: onCancel,
        onConfirm: onConfirm,
        confirmText: confirmTextToEnable,
        confirmModalTitle: confirmModalTitle,
        confirmModalCancelCaption: confirmModalCancelCaption,
        confirmModalConfirmCaption: confirmModalConfirmCaption,
      );
    }
    if (confirmText != null &&
        (newValue != oldValue || (newValue == null && oldValue == null))) {
      return _showDialog(
        context: context,
        onCancel: onCancel,
        onConfirm: onConfirm,
        confirmText: confirmText,
        confirmModalTitle: confirmModalTitle,
        confirmModalCancelCaption: confirmModalCancelCaption,
        confirmModalConfirmCaption: confirmModalConfirmCaption,
      );
    }
    onConfirm?.call();
  }

  Future<Widget?> _showDialog({
    required BuildContext context,
    Function? onConfirm,
    Function? onCancel,
    String? confirmText,
    String? confirmModalTitle,
    String? confirmModalCancelCaption,
    String? confirmModalConfirmCaption,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: confirmModalTitle == ""
              ? null
              : Text(confirmModalTitle ?? "Confirm"),
          content: confirmText != null ? Text(confirmText) : null,
          actions: <Widget>[
            confirmModalCancelCaption == ""
                ? Container()
                : TextButton(
              child: Text(
                confirmModalCancelCaption ?? "Cancel",
                style: TextStyle(color: Theme.of(context).disabledColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                return onCancel?.call();
              },
            ),
            confirmModalConfirmCaption == ""
                ? Container()
                : TextButton(
              child: Text(confirmModalConfirmCaption ?? "Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                return onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }
}

typedef ChildBuilder = Widget Function(BuildContext context, bool visibleByDefault);

class _Enableable {
  Widget wrapEnableable({
    required BuildContext context,
    required String? enabledIfKey,
    required bool visibleByDefault,
    required ChildBuilder childBuilder,
  }) {
    if (enabledIfKey == null) {
      return childBuilder(context, visibleByDefault);
    }
    return __onEnabledChanged(
      context: context,
      enabledIfKey: enabledIfKey,
      visibleByDefault: visibleByDefault,
      childBuilder: childBuilder,
    );
  }

  StreamBuilder<bool> __onEnabledChanged({
    required BuildContext context,
    required String enabledIfKey,
    required bool visibleByDefault,
    required ChildBuilder childBuilder,
  }) {
    return Settings().onBoolChanged(
      settingKey: enabledIfKey,
      defaultValue: visibleByDefault,
      childBuilder: (BuildContext context, bool enabled) {
        return childBuilder(context, enabled);
      },
    );
  }
}
