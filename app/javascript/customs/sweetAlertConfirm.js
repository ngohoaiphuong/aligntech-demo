import { alertWarning } from 'shared/alert_service'

(function ($) {
  function showSweetAlertConfirmationDialog(message, element, title) {
    alertWarning(
      title,
      message,
      (result) => {
        confirmed(element, result)
      }
    )
  }

  const confirmed = (element, result) => {
    if (result.value) {
      element.removeAttribute('data-confirm')
      element.click()
    }
  }

  function sweetAlertConfirm(title) {
    Rails.confirm = function (message, element) {
      showSweetAlertConfirmationDialog(message, element, title)
      return false
    };
  }

  $.sweetAlertConfirm = {
    init: function(title) {
      sweetAlertConfirm(title || 'Application')
    }
  }
})(jQuery);
