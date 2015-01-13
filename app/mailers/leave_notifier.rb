class LeaveNotifier < SystemNotifier

  def new_leave(leave)
    @leave = leave
    @leader = leave.staff.leader

    @cc = leave.emails_cc
    @cc = @cc.push(@leader.email) if @leader

    mail(to: Setting['EMAIL_NOTIFIER'], cc: @cc, subject: t('mail.hr.subject')) do |format|
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

  def warning_sick_leave(leave)
    @leave = leave
    mail(to: leave.staff_email, cc: Setting['EMAIL_NOTIFIER'], subject: t('mail.warning_sick.subject')) do |format|
      format.html {render 'notifier/leave/warning_sick_leave'}
    end
  end

  def warning_urgent_leave(leave)
    @leave = leave
    mail(to: leave.staff_email, cc: Setting['EMAIL_NOTIFIER'], subject: t('mail.warning_urgent.subject')) do |format|
      format.html {render 'notifier/leave/warning_urgent_leave'}
    end
  end

  def warning_3_least_days(leave)
    @leave = leave
    mail(to: leave.staff_email, subject: t('mail.warning_3_least_days.subject')) do |format|
      format.html {render 'notifier/leave/warning_3_least_days'}
    end
  end
end
