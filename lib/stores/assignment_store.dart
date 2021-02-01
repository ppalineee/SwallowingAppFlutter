import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/assignment.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'assignment_store.g.dart';

class AssignmentStore = _AssignmentStore with _$AssignmentStore;

abstract class _AssignmentStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _AssignmentStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AssignmentList> emptyAssignmentListResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<AssignmentList> fetchAssignmentListFuture =
  ObservableFuture<AssignmentList>(emptyAssignmentListResponse);

  @observable
  AssignmentList assignmentList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchAssignmentListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getAssignmentList() async {
    final future = _repository.getAssignmentList();
    fetchAssignmentListFuture = ObservableFuture(future);

    future.then((assignmentList) {
      this.assignmentList = assignmentList;
      success = true;
    }).catchError((error) {
      success = false;
    });
  }
}