import Cookies from 'js-cookie'

export const getChannelId = function() {
  let channelId = Math.random()
  Cookies.set('channelID', channelId)
  return channelId
}

export const getUuid = function() {
  return Cookies.get('uuid')
}

