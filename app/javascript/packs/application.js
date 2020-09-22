import 'bootstrap'

require("rails-ujs-confirm").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "controllers"

import '../stylesheets/application'
import I18n from 'shared/locale.js.erb'
import '../customs/sweetAlertConfirm'
import { NoticeMessage } from '../shared/notice_message'
import { SystemListenChannel } from 'channels/system_listen_channel'

window.notice = new NoticeMessage()

$(document).on('turbolinks:load', function () {
  $.sweetAlertConfirm.init(I18n.t('confirm.confirmation_title'))
  console.log('Rendering')
  SystemListenChannel.get()
})

$(document).on('turbolinks:render', function () {
  console.log('Rendering')
  SystemListenChannel.get()
})
