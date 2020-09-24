import { TaskChannel } from 'channels/task_channel'

export default class UserTask {
  constructor() {
    if (UserTask.exists) {
      return UserTask.singleton;
    }

    UserTask.exists = true;
    UserTask.singleton = this;
    this._channel = TaskChannel.get();

    return this
  }

  static get() {
    return new UserTask();
  }

  get channel() {
    return this._channel
  }
}