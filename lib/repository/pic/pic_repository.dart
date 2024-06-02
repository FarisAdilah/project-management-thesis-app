import 'package:project_management_thesis_app/repository/pic/dataModel/pic_dm.dart';
import 'package:project_management_thesis_app/repository/pic/firebaseModel/pic_firebase.dart';
import 'package:project_management_thesis_app/services/repo_base.dart';
import 'package:project_management_thesis_app/utils/constant.dart';

class PicRepository with RepoBase {
  PicRepository get instance => PicRepository();

  Future<List<PicDM>> getAllPic() async {
    List collection = await getDataCollection(CollectionType.pics.name);

    List<PicFirebase> picList = [];

    for (var element in collection) {
      PicFirebase pic = PicFirebase.fromFirestoreDoc(element);
      picList.add(pic);
    }

    List<PicDM> picDMList = [];
    for (var element in picList) {
      PicDM picDM = PicDM();
      picDM.id = element.id;
      picDM.email = element.email;
      picDM.name = element.name;
      picDM.phoneNumber = element.phoneNumber;
      picDM.role = element.role;

      picDMList.add(picDM);
    }

    return picDMList;
  }

  Future<PicDM> getPicById(String id) async {
    var data = await getDataDocument(CollectionType.pics.name, id);
    PicFirebase pic = PicFirebase.fromFirestoreDoc(data);

    PicDM picDM = PicDM();
    picDM.id = pic.id;
    picDM.email = pic.email;
    picDM.name = pic.name;
    picDM.phoneNumber = pic.phoneNumber;
    picDM.role = pic.role;

    return picDM;
  }
}
