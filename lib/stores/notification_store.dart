import 'package:swallowing_app/data/repository.dart';
import 'package:swallowing_app/models/notification.dart';
import 'package:swallowing_app/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  // repository instance
  Repository _repository;

  // constructor:---------------------------------------------------------------
  _NotificationStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  @observable
  NotificationList notificationList;

  @action
  Future<NotificationList> getNotification() async {
    notificationList = await _repository.getNotification();
    return notificationList;
  }

  @action
  Future<bool> readNotification() async {
    return await _repository.readNotification();
  }
}