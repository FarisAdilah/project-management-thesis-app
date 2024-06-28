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

enum MenuType {
  home,
  staff,
  vendor,
  client,
  profile,
}

enum StorageType {
  user,
}

enum ProjectFieldType {
  userId,
  clientId,
  vendorId,
  pmId,
}

enum TaskFieldType {
  timelineId,
  staffId,
}

enum ProjectStatusType {
  pending,
  rejected,
  ongoing,
  closing,
  pendingClose,
  rejectClose,
  completed,
}

enum PaymentStatusType {
  pending,
  approved,
  rejected,
}

enum TaskStatusType {
  notStarted,
  onProgress,
  completed,
  overdue,
}

class Constant {
  static const bool showLog = true;
  static const String logIdentifier = "PenTools-log";
}
