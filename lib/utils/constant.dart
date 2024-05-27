enum UserType {
  supervisor,
  admin,
  projectManager,
  staff,
}

enum CollectionType {
  users,
  projects,
  timelines,
  scheduleTasks,
  clients,
  vendors,
  payments,
}

enum ExternalType {
  vendor,
  client,
}

class Constant {
  static const bool showLog = true;
  static const String logIdentifier = "PenTools-log";
}
