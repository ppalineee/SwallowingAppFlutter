import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/notification.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _NotificationStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<NotificationList> emptyNotificationListResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<NotificationList> fetchNotificationListFuture =
  ObservableFuture<NotificationList>(emptyNotificationListResponse);

  @observable
  NotificationList notificationList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchNotificationListFuture.status == FutureStatus.pending;

  @action
  Future<NotificationList> getNotification() async {
    return await _repository.getNotification();
  }

  @action
  Future<bool> readNotification() async {
    return await _repository.readNotification();
  }
}