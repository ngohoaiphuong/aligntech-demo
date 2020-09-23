module TasksHelper
  def status_color(task)
    {
      openning: 'btn-info',
      process: 'btn-success', 
      closed: 'btn-secondary'
    }[task.status.to_sym]
  end

  def priority_color(task, important=true)
    cls_colours = {
      important: 'btn-danger',
      urgent: 'btn-warning',
      default: 'btn-secondary'
    }
    return (task.important? || task.both?) ? cls_colours[:important] : cls_colours[:default] if important
    (task.urgent? || task.both?) ? cls_colours[:urgent] : cls_colours[:default]
  end

  def priority_text(task, important=true)
    return (task.important? || task.both?) ? 'important' : 'not impt' if important
    (task.urgent? || task.both?) ? 'urgent' : 'not urgt' 
  end

  def action_text(task)
    return t('form.buttons.start') if task.openning?
    t('form.buttons.done')
  end

  def status_text(task)
    return 'open' if task.openning?
    task.status
  end

  def btn_color(task)
    return 'btn-outline-secondary' if task.openning?
    'btn-primary'
  end
end
