import createChannel from './cable'
import {
  getChannelId,
  getUuid
} from 'shared/utils'

import CableReady from 'cable_ready';

function registerSystemListenChannel() {
  const channelName = 'SystemListenChannel'

  return createChannel({
    channel: channelName,
    channel_id: getChannelId(),
    session: getUuid()
  }, {
    received(data) {
      if(data.cableReady) CableReady.perform(data.operations)
    }
  })
}

const SystemListenChannel = (function() {
  let channel;

  return {
    get: function() {
      if (!channel) {
        channel = registerSystemListenChannel()
      }
      return channel
    }
  }
})()

export {
  SystemListenChannel
}
