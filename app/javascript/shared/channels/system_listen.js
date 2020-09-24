import { SystemListenChannel } from 'channels/system_listen_channel'

export default class SystemListen {
  constructor() {
    if (SystemListen.exists) {
      return SystemListen.singleton;
    }

    SystemListen.exists = true;
    SystemListen.singleton = this;
    this._channel = SystemListenChannel.get();

    return this
  }

  static get() {
    return new SystemListen();
  }

  get channel() {
    return this._channel
  }
}