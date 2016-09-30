class TicketsMailer < ApplicationMailer
  def buy_ticket(ticket)
    @ticket = ticket
    @user = ticket.user
    mail(to: @user.email, subject: t('tickets_mailer.buy_ticket.subject'))
  end

  def cancel_ticket(ticket)
    @serial_number = ticket[:serial_number]
    @user = ticket[:user]
    mail(to: @user.email, subject: t('tickets_mailer.cancel_ticket.subject'))
  end
end
