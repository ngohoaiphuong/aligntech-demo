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

window.notice = new NoticeMessage()

$(document).on('turbolinks:load', function () {
  $.sweetAlertConfirm.init(I18n.t('confirm.confirmation_title'))
})