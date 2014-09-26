class LateNotifier < SystemNotifier
  def more_late(late)
    @late = late
    mail(to: Setting['EMAIL_NOTIFIER'], subject: t('mail.late.subject')) do |format|
      format.html { render 'notifier/late/more_late' }
    end
  end
end
