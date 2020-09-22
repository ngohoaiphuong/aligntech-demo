import Cookies from 'js-cookie'

const channelId = Math.random()
export const getChannelId = function() {
  Cookies.set('channelID', channelId)
  console.log(Cookies.get('uuid'))
  return channelId
}

export const getUuid = function() {
  return Cookies.get('uuid')
}

