import 'package:project_management_thesis_app/repository/scheduleTask/dataModel/schedule_task_dm.dart';
import 'package:project_management_thesis_app/repository/scheduleTask/schedule_task_repository.dart';
import 'package:project_management_thesis_app/repository/timeline/dataModel/timeline_dm.dart';
import 'package:project_management_thesis_app/repository/timeline/firebaseModel/timeline_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class TimelineRepository with RepoBase {
  static TimelineRepository get instance => TimelineRepository();

  Future<List<TimelineDM>> getAllTimeline() async {
    List collection = await getDataCollection(CollectionType.timelines.name);

    List<TimelineFirebase> timelineList = [];

    for (var element in collection) {
      TimelineFirebase timeline = TimelineFirebase.fromFirestoreList(element);
      timelineList.add(timeline);
    }

    List<TimelineDM> timelineDMList = [];

    for (var element in timelineList) {
      TimelineDM timelineDM = TimelineDM();
      timelineDM.id = element.id;
      timelineDM.startDate = element.startDate;
      timelineDM.endDate = element.endDate;
      timelineDM.timelineName = element.timelineName;

      List<ScheduleTaskDM> taskDMList = [];
      List<String> taskFirebaseList = element.tasksId ?? [];
      if (element.tasksId?.isNotEmpty ?? false) {
        for (var element in taskFirebaseList) {
          ScheduleTaskDM taskDM =
              await ScheudleTaskRepository().getScheduleTaskById(element);

          taskDMList.add(taskDM);
        }
      }

      timelineDM.scheduleTask = taskDMList;
      timelineDMList.add(timelineDM);
    }

    return timelineDMList;
  }

  Future<List<TimelineDM>> getMultipleTimeline(List<String> ids) async {
    List<TimelineDM> timelineDMList = [];

    for (var id in ids) {
      TimelineDM timelineDM = await getTimelineById(id);
      timelineDMList.add(timelineDM);
    }

    return timelineDMList;
  }

  Future<TimelineDM> getTimelineById(String id) async {
    var data = await getDataDocument(CollectionType.timelines.name, id);
    TimelineFirebase timeline = TimelineFirebase.fromFirestoreDoc(data);

    TimelineDM timelineDM = TimelineDM();
    timelineDM.id = timeline.id;
    timelineDM.startDate = timeline.startDate;
    timelineDM.endDate = timeline.endDate;
    timelineDM.timelineName = timeline.timelineName;

    List<ScheduleTaskDM> taskDMList = [];
    List<String> taskFirebaseList = timeline.tasksId ?? [];
    if (timeline.tasksId?.isNotEmpty ?? false) {
      for (var element in taskFirebaseList) {
        ScheduleTaskDM taskDM =
            await ScheudleTaskRepository().getScheduleTaskById(element);

        taskDMList.add(taskDM);
      }
    }

    timelineDM.scheduleTask = taskDMList;

    return timelineDM;
  }
}
