enum PAGES {
  selectRoles,
  sideDrawer,
  error,
}

extension AppPageExtension on PAGES {

  String get screenPath {
    switch (this) {
      case PAGES.sideDrawer:
        return "/";
      case PAGES.selectRoles:
        return "/selectRoles";
      // case PAGES.error:
      //   return "/error";
      default:
        return "/";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.sideDrawer:
        return "SIDE DRAWER";
      case PAGES.selectRoles:
        return "SELECT ROLES";
      // case PAGES.error:
      //   return "ERROR";
      default:
        return "SIDE DRAWER";
    }
  }

  String get screenTitle {
    switch (this) {
      case PAGES.sideDrawer:
        return "Side Drawer";
      case PAGES.selectRoles:
        return "Select Roles";
      // case PAGES.error:
      //   return "Error";
      default:
        return "Side Drawer";
    }
  }

}