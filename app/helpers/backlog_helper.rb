module BacklogHelper
  def status_color(task)
    {
      open: 'btn-info',
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
    return t('form.buttons.start') if task.open?
    t('form.buttons.done')
  end

  def btn_color(task)
    return 'btn-outline-secondary' if task.open?
    'btn-primary'
  end
end
