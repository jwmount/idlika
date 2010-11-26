class MemberMailer < ActionMailer::Base

  def invitation(friend, from, message)
    subject     'Invitation'
    recipients  friend[:email]
    from        from
    bcc         'info@idlika.com'
    sent_on     Time.now
    headers     {}
    body        :friend => friend
  end
  
end