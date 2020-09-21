import Swal from 'sweetalert2'
import I18n from 'shared/locale.js.erb'

function alertWarning(title, message, callback) {
  Swal.fire({
    title: title,
    html: message,
    icon: 'warning',
    confirmButtonText: I18n.t('confirm.ok'),
    cancelButtonText: I18n.t('confirm.cancel'),
    showCancelButton: true,
    showCloseButton: true,
    reverseButtons: true,
    buttonsStyling: false,
    customClass: {
      confirmButton: 'btn btn-primary px-4 m-2',
      cancelButton: 'btn btn-outline-primary px-4 m-2',
    }
  })
  .then((result) => {
    callback && callback(result)
  });
}

function alertError(message) {
  if (message) {
    Swal.fire({
      html: message,
      icon: 'error',
    })
  }
}

export {
  alertWarning,
  alertError
}
