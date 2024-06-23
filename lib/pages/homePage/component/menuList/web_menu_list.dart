import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/globalComponent/textCustom/custom_text.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/model/menus.dart';

class WebMenuList extends StatelessWidget {
  final List<Menus> menus;
  final Function(Menus) onTapMenu;
  final int selectedMenuId;

  const WebMenuList({
    super.key,
    required this.menus,
    required this.onTapMenu,
    required this.selectedMenuId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menus.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Menus menu = menus[index];

        return _buildMenuTile(menu, onTapMenu, selectedMenuId);
      },
    );
  }

  Widget _buildMenuTile(
      Menus menu, Function(Menus)? onTapMenu, int selectedMenuId) {
    return InkWell(
      onTap: () {
        if (onTapMenu != null) {
          Helpers.writeLog("menu: ${menu.name}");
          onTapMenu(menu);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: menu.id == selectedMenuId
              ? AssetColor.whitePrimary
              : AssetColor.blueDark,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              menu.icon,
              color: menu.id == selectedMenuId
                  ? AssetColor.blueDark
                  : AssetColor.whitePrimary,
              size: 15,
            ),
            const SizedBox(
              width: 20,
            ),
            CustomText(
              menu.name ?? "Menu",
              color: menu.id == selectedMenuId
                  ? AssetColor.blueDark
                  : AssetColor.whitePrimary,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
