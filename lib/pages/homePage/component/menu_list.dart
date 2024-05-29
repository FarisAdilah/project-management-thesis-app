import 'package:flutter/material.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';
import 'package:project_management_thesis_app/utils/helpers.dart';
import 'package:project_management_thesis_app/utils/model/menus.dart';

class MenuList extends StatelessWidget {
  final List<Menus> menus;
  final Function(Menus) onTapMenu;
  final int selectedMenuId;

  const MenuList({
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
              : AssetColor.blueTertiaryAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              menu.icon,
              color: menu.id == selectedMenuId
                  ? AssetColor.blueTertiaryAccent
                  : AssetColor.whitePrimary,
              size: 15,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              menu.name ?? "Menu",
              style: TextStyle(
                color: menu.id == selectedMenuId
                    ? AssetColor.blueTertiaryAccent
                    : AssetColor.whitePrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
