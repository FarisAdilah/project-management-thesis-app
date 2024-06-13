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
      timelineDM.name = element.name;
      timelineDM.projectId = element.projectId;

      timelineDMList.add(timelineDM);
    }

    return timelineDMList;
  }

  Future<List<TimelineDM>> getMultipleTimeline(String projectId) async {
    List collection = await getMultipleDocument(
      CollectionType.timelines.name,
      "projectId",
      projectId,
    );

    List<TimelineFirebase> timelineList = [];
    for (var timeline in collection) {
      TimelineFirebase timelineDoc =
          TimelineFirebase.fromFirestoreList(timeline);
      timelineList.add(timelineDoc);
    }

    List<TimelineDM> timelineDMList = [];
    for (var element in timelineList) {
      TimelineDM timelineDM = TimelineDM();
      timelineDM.id = element.id;
      timelineDM.startDate = element.startDate;
      timelineDM.endDate = element.endDate;
      timelineDM.name = element.name;
      timelineDM.projectId = element.projectId;

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
    timelineDM.name = timeline.name;
    timelineDM.projectId = timeline.projectId;

    return timelineDM;
  }
}
