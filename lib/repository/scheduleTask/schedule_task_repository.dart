import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/firebaseModel/schedule_taks_firebase.dart';
import 'package:project_management_thesis_app/repository/user/dataModel/user_dm.dart';
import 'package:project_management_thesis_app/repository/user/user_repository.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class ScheudleTaskRepository with RepoBase {
  static ScheudleTaskRepository get instance => ScheudleTaskRepository();

  Future<List<ScheduleTaskDM>> getAllScheduleTask() async {
    List collection =
        await getDataCollection(CollectionType.scheduleTasks.name);

    List<ScheduleTaskFirebase> scheduleTaskList = [];
    for (var element in collection) {
      ScheduleTaskFirebase task =
          ScheduleTaskFirebase.fromFirestoreList(element);
      scheduleTaskList.add(task);
    }

    List<ScheduleTaskDM> taskDM = [];
    for (var element in scheduleTaskList) {
      ScheduleTaskDM task = ScheduleTaskDM();
      task.id = element.id;
      task.name = element.name;
      task.startDate = element.startDate;
      task.endDate = element.endDate;

      if (element.staffId != null) {
        UserDM staff = await UserRepository().getUserById(element.staffId!);
        task.staff = staff;
      } else {
        return [];
      }
      taskDM.add(task);
    }

    return taskDM;
  }

  Future<ScheduleTaskDM> getScheduleTaskById(String id) async {
    var data = await getDataDocument(CollectionType.scheduleTasks.name, id);
    ScheduleTaskFirebase task = ScheduleTaskFirebase.fromFirestoreDoc(data);
    ScheduleTaskDM taskDM = ScheduleTaskDM();
    taskDM.id = task.id;
    taskDM.name = task.name;
    taskDM.startDate = task.startDate;
    taskDM.endDate = task.endDate;

    if (task.staffId != null && (task.staffId?.isNotEmpty ?? false)) {
      UserDM staff = await UserRepository().getUserById(task.staffId!);
      taskDM.staff = staff;
    } else {
      return ScheduleTaskDM();
    }

    return taskDM;
  }
}
