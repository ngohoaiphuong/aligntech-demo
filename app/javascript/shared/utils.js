import Cookies from 'js-cookie'

const channelId = Math.random()
export const getChannelId = function() {
  return  Cookies.get('uuid')
}

export const getUuid = function() {
  return Cookies.get('uuid')
}

export const getCurrentUser = function() {
  return Cookies.get('user_id')
}
