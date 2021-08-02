//if you're likely to create multiple implements for those classes ->
//you can consider creating abstract based class
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/app/services/firestore_service.dart';

import 'api_path.dart';

abstract class Database {
  Future<void> setJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>> jobsStream();
}

//toIso8601String -> convert daytime object to string
//we can't really use this method for editing an existing job
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({this.uid}) : assert(uid != null);
  final String uid;

  //impossible (now it is private)
  // final _service = FirestoreService();

  //it is ensure that only one object of type FirestoreService can ever be created
  final _service = FirestoreService.instances;

  //for write (create & edit)
  @override
  Future<void> setJob(Job job) => _service.setData(
        //현재 시각을 path 로 설정하여 항상 고유한 경로에 Job을 생성
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );

  @override
  Future<void> deleteJob(Job job) => _service.deleteData(
        path: APIPath.job(uid, job.id),
      );

  //for read
  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );
}
