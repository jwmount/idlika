class MemberMailer < ActionMailer::Base

  def invitation(user)
    subject     'Invitation'
#    body        {}
    recipients  'john@venuesoftware.com'
    from        'jwmount0@gmail.com'
    sent_on     Time.now
    headers     {}
    body        :user => user
  end
end