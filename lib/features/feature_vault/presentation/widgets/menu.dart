// define your context menu entries
import 'package:bit_key/core/constants/app_constant.dart';
import 'package:bit_key/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

final entries = <ContextMenuEntry>[
  // const MenuHeader(text: "Context Menu"),
  CustomMenuItem(
    label: const Text('Login'),
    icon: const Icon(Icons.copy),
    onSelected: (value) {
      // implement copy
    },
  ),
  CustomMenuItem(
    label: const Text('Card'),
    icon: const Icon(Icons.cut),
    onSelected: (value) {
      // implement cut
    },
  ),
  CustomMenuItem(
    label: const Text('Identity'),
    icon: const Icon(Icons.paste),
    onSelected: (value) {
      // implement paste
    },
  ),

  CustomMenuItem(
    label: const Text('Folder'),
    icon: const Icon(Icons.paste),
    onSelected: (value) {
      // implement paste
    },
  ),
];

// initialize a context menu
ContextMenu getMenu(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return ContextMenu(
    boxDecoration: BoxDecoration(
      boxShadow: [
        BoxShadow(blurRadius: AppConstant.appPadding, color:AppColor.secondary.withOpacity(0.05) ),
        
      ],
      color: AppColor.secondary.withOpacity(0.02)
    ),
    entries: entries,
    position: Offset(size.width, size.height * 0.72),
    padding: const EdgeInsets.all(8.0),
  );
}

final class CustomMenuItem<T> extends ContextMenuItem<T> {
  final Widget? icon;
  final Widget label;
  final SingleActivator? shortcut;
  final Widget? trailing;
  final BoxConstraints? constraints;
  final Color? textColor;

  const CustomMenuItem({
    this.icon,
    required this.label,
    this.shortcut,
    this.trailing,
    super.value,
    super.onSelected,
    super.enabled,
    this.constraints,
    this.textColor,
  });

  const CustomMenuItem.submenu({
    this.icon,
    required this.label,
    required List<ContextMenuEntry<T>> items,
    this.shortcut,
    this.trailing,
    super.onSelected,
    super.enabled,
    this.constraints,
    this.textColor,
  }) : super.submenu(items: items);

  @override
  String get debugLabel => "${super.debugLabel} - $label";

  @override
  Widget builder(
    BuildContext context,
    ContextMenuState menuState, [
    FocusNode? focusNode,
  ]) {
    bool isFocused = menuState.focusedEntry == this;

    final background = AppColor.transparent;
    final focusedBackground = AppColor.transparent;
    final adjustedTextColor = AppColor.primary;
    final normalTextColor = textColor ?? adjustedTextColor;
    final focusedTextColor = textColor ?? Colors.blue;
    final disabledTextColor = Colors.green;
     
    final foregroundColor = !enabled
        ? disabledTextColor
        : isFocused
        ? focusedTextColor
        : normalTextColor;
    final textStyle = TextStyle(color: foregroundColor, height: 1.0);
    final leadingIconThemeData = IconThemeData(
      size: 16.0,
      color: normalTextColor,
    );
    final trailingIconThemeData = IconThemeData(
      size: 16.0,
      color: normalTextColor,
    );

    // ~~~~~~~~~~ //

    return ConstrainedBox(
      constraints:
          constraints ?? const BoxConstraints.expand(height: kMenuItemHeight),
      child: Material(
        color: !enabled
            ? Colors.transparent
            : isFocused
            ? focusedBackground
            : background,
        borderRadius: BorderRadius.circular(4.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: !enabled ? null : () => handleItemSelection(context),
          canRequestFocus: false,
          hoverColor: Colors.transparent,
          child: Row(
            children: [
              SizedBox.square(
                dimension: kMenuItemIconSize,
                child: icon != null
                    ? IconTheme(data: leadingIconThemeData, child: icon!)
                    : null,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: DefaultTextStyle(
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  child: label,
                ),
              ),
              if (shortcut != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 32.0),
                  child: DefaultTextStyle(
                    style: textStyle.apply(
                      color: adjustedTextColor.withValues(alpha: 0.6),
                    ),
                    child: Text(shortcut!.toKeyString()),
                  ),
                ),
              const SizedBox(width: 8.0),
              trailing ??
                  SizedBox.square(
                    dimension: kMenuItemIconSize,
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: IconTheme(
                        data: trailingIconThemeData,
                        child: Icon(isSubmenuItem ? Icons.arrow_right : null),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
