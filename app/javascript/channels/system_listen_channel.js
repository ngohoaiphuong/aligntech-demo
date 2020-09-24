import createChannel from './cable'
import {
  getChannelId,
  getUuid
} from 'shared/utils'

import CableReady from 'cable_ready';
// import consumer from "./consumer"

// consumer.subscriptions.create({
//   channel: 'SystemListenChannel',
//   channel_id: getChannelId(),
//   session: getUuid()
// }, {
//   received(data) {
//     if(data.cableReady) CableReady.perform(data.operations)
//   }
// });

function registerSystemListenChannel() {
  return createChannel('SystemListenChannel', {
    received(data) {
      console.log('SystemListenChannel')
      console.log(data)
      console.log('----------------------------------')
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
