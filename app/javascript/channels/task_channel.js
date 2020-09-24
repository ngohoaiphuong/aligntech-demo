import createChannel from "./cable";
import CableReady from "cable_ready";
import { getCurrentUser } from "shared/utils";

function registerTaskChannel() {
  return createChannel(
    {
      channel: "TaskChannel",
      user_id: getCurrentUser(),
    },
    {
      received(data) {
        if (data.cableReady) CableReady.perform(data.operations);
      },
    }
  );
}

const TaskChannel = (function () {
  let channel;

  return {
    get: function () {
      if (!channel) {
        channel = registerTaskChannel();
      }
      return channel;
    },
  };
})();

export { TaskChannel };
