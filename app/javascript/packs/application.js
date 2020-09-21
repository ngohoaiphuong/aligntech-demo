require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "controllers"

import I18n from 'shared/locale.js.erb'

$(document).on('turbolinks:load', function () {
  console.log(I18n.t('hello'))
})