import Cookies from 'js-cookie'

const channelId = Math.random()
export const getChannelId = function() {
  return channelId
}

export const getUuid = function() {
  return Cookies.get('uuid')
}

