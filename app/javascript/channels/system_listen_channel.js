import createChannel from './cable'
import {
  getChannelId,
  getUuid
} from 'shared/utils'

import CableReady from 'cable_ready';

function registerSystemListenChannel() {
  const channelName = 'SystemListenChannel'
  const channelId   = getChannelId()
  const session     = getUuid()

  return createChannel({
    channel: channelName,
    channel_id: channelId,
    session: session
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
