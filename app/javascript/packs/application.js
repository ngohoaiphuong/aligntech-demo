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
import SystemListen from '../shared/channels/system_listen';

import consumer from "../channels/consumer"
import UserTask from '../shared/channels/user_task';
import { hideAlert } from 'shared/alert_service'

window.notice = new NoticeMessage()

$(document).on('turbolinks:load', function () {
  consumer.subscriptions.subscriptions.forEach(
    (subscription) => {
      if (JSON.parse(subscription.identifier).channel == 'TaskChannel') {
        consumer.subscriptions.remove(subscription)
      }
    }
  )
  
  $.sweetAlertConfirm.init(I18n.t('confirm.confirmation_title'))
  SystemListen.get()  
  UserTask.get()
  hideAlert()
})
