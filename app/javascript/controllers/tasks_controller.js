import ApplicationController from './application_controller'
import { alertWarning } from 'shared/alert_service'
import I18n from 'shared/locale.js.erb'
import Cookies from 'js-cookie';

/* This is the custom StimulusReflex controller for TasksReflex.
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends ApplicationController {
  done(event) {
    event.preventDefault()
    const el = event.currentTarget
    const id = el.getAttribute("data-id")
    alertWarning(
      I18n.t('confirm.confirmation_title'),
      I18n.t('confirm.done'),
      (result) => {
        if(result.isConfirmed) {
          this.stimulate("TasksReflex#done", id)
        }
      }
    )
  }

  start(event) {
    event.preventDefault()
    const el = event.currentTarget
    const id = el.getAttribute("data-id")
    alertWarning(
      I18n.t('confirm.confirmation_title'),
      I18n.t('confirm.start'),
      (result) => {
        if(result.isConfirmed) {
          this.stimulate("TasksReflex#start", id)
        }
      }
    )
  }

  remove(event) {
    event.preventDefault()
    const el = event.currentTarget
    const id = el.getAttribute("data-id")
    alertWarning(
      I18n.t('confirm.confirmation_title'),
      I18n.t('confirm.delete_task'),
      (result) => {
        if(result.isConfirmed) {
          this.stimulate("TasksReflex#remove", id, Cookies.get('hide_closed_task'))
        }
      }
    )
  }
}
