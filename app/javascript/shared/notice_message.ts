import iziToast from 'izitoast/dist/js/iziToast'

export class NoticeMessage {

  private config = {
    message: '',
    position: 'topRight',
    timeout: 5000,
    progressBar: false,
    closeOnClick: true,
    maxWidth: '500px'
  }

  constructor() {
  }

  error(message: any, callBack = undefined, options = {}) {
    iziToast.error(this.generateMessage(message, callBack, options))
  }

  info(message: any, callBack = undefined, options = {}) {
    iziToast.info(this.generateMessage(message, callBack, options))
  }

  warning(message: any, callBack = undefined, options = {}) {
    iziToast.warning(this.generateMessage(message, callBack, options))
  }

  success(message: any, callBack = undefined, options = {}) {
    iziToast.success(this.generateMessage(message, callBack, {
      timeout: 1500
    }))
  }

  destroy() {
    iziToast.destroy()
  }

  private generateMessage(message: any, callBack = undefined, options = {}) {
    return {
      ...this.config,
      ...{
        message: message,
        onClosed: callBack ? callBack() : () => {}
      },
      ...options
    }
  }
}
