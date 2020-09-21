import 'bootstrap'

require("rails-ujs-confirm").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "controllers"

import '../stylesheets/application'
import I18n from 'shared/locale.js.erb'
import '../customs/sweetAlertConfirm'

$(document).on('turbolinks:load', function () {
  console.log(I18n.t('hello'))
  $.sweetAlertConfirm.init(I18n.t('confirm.confirmation_title'))
})