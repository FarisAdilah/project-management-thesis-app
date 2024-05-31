import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_management_thesis_app/utils/constant.dart';
import 'package:project_management_thesis_app/utils/model/menus.dart';

class MenuUtility {
  List<Menus> getAllMenu() => [
        Menus(
          id: 1,
          name: "Home",
          icon: FontAwesomeIcons.house,
          type: MenuType.home,
          selected: false,
        ),
        Menus(
          id: 2,
          name: "Staff",
          icon: FontAwesomeIcons.users,
          type: MenuType.staff,
          selected: false,
        ),
        Menus(
          id: 3,
          name: "Vendor",
          icon: FontAwesomeIcons.userGear,
          type: MenuType.vendor,
          selected: false,
        ),
        Menus(
          id: 4,
          name: "Client",
          icon: FontAwesomeIcons.userTie,
          type: MenuType.client,
          selected: false,
        ),
        Menus(
          id: 5,
          name: "Profile",
          icon: FontAwesomeIcons.userPen,
          type: MenuType.profile,
          selected: false,
        )
      ];
}
