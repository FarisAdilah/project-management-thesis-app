import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/utils/asset_color.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildMenuTile('Home', FontAwesomeIcons.house),
      ],
    );
  }

  Widget _buildMenuTile(String menu, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AssetColor.whitePrimary,
            size: 15,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            menu,
            style: const TextStyle(
              color: AssetColor.whitePrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
