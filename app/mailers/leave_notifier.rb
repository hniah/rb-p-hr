class LeaveNotifier < SystemNotifier

  def new_leave(leave)
    @leave = leave
    mail(to: Setting['EMAIL_NOTIFIER'], subject: t('mail.hr.subject')) do |format|
      format.html { render 'notifier/leave/new_leave' }
    end
  end

  def approved(leave)
    @leave = leave
    if !leave.category.sick?
      mail(to: @leave.staff_email, subject: t('mail.approve.subject')) do |format|
        format.html {render 'notifier/leave/approved_leave'
        }
      end
    else
      mail(to: @leave.staff_email, subject: t('mail.sickly.subject')) do |format|
        format.html {render 'notifier/leave/sick_leave'
        }
      end
    end

  end

  def rejected(leave)
    @leave = leave
    mail(to: leave.staff_email, subject: t('mail.reject.subject')) do |format|
      format.html {render 'notifier/leave/rejected_leave'
      }
    end
  end
end
