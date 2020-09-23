import Cookies from 'js-cookie'

const channelId = Math.random()
export const getChannelId = function() {
  return  Cookies.get('uuid')
  // if(Cookies.get('channelID') === undefined) {
  //   Cookies.set('channelID', channelId)
  // }
  // console.log(`userID: ${Cookies.get('user_id')}`)
  // if(Cookies.get('user_id')) {
  //   console.log(`b.userID: ${Cookies.get('user_id')}`)
  //   Cookies.set('channelID', Cookies.get('uuid'))
  // }
  // return Cookies.get('channelID')
}

export const getUuid = function() {
  return Cookies.get('uuid')
}

