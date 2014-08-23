class LeaveNotifier < SystemNotifier

  def new_leave(leave)
    @leave = leave
    mail(to: ENV['EMAIL_NOTIFIER'], subject: t('mail.hr.subject')) do |format|
      format.html { render 'notifier/new_leave' }
    end
  end

  def approved(leave)
    @leave = leave
    mail(to: @leave.staff_email, subject: t('mail.approve.subject')) do |format|
      format.html {render 'notifier/approved_leave'
      }
    end
  end

  def rejected(leave)
    @leave = leave
    mail(to: leave.staff_email, subject: t('mail.reject.subject')) do |format|
      format.html {render 'notifier/rejected_leave'
      }
    end
  end
end
