import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/firebaseModel/schedule_taks_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class ScheduleTaskRepository with RepoBase {
  static ScheduleTaskRepository get instance => ScheduleTaskRepository();

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
      task.timelineId = element.timelineId;
      task.staffId = element.staffId;
      task.status = element.status;

      taskDM.add(task);
    }

    return taskDM;
  }

  Future<List<ScheduleTaskDM>> getMultipleScheduleTask(
    String id,
    TaskFieldType field,
  ) async {
    List collection = await getMultipleDocument(
      CollectionType.scheduleTasks.name,
      field.name,
      id,
      isArray: false,
    );

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
      task.timelineId = element.timelineId;
      task.staffId = element.staffId;
      task.status = element.status;

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
    taskDM.timelineId = task.timelineId;
    taskDM.staffId = task.staffId;
    taskDM.status = task.status;

    return taskDM;
  }

  Future<String> createTask(ScheduleTaskFirebase task) async {
    return await createData(
      CollectionType.scheduleTasks.name,
      task.toFirestore(),
    );
  }

  Future<bool> updateTask(ScheduleTaskFirebase task) async {
    return await updateData(
      CollectionType.scheduleTasks.name,
      task.id ?? "",
      task.toFirestore(),
    );
  }

  Future<bool> deleteTask(String id) async {
    return await deleteData(CollectionType.scheduleTasks.name, id);
  }
}
