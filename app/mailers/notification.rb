class Notification < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.order_confirmation.subject
  #

  #this method is like a controller in this method it will have its own view file.
  # have to setup smtp settings in the config/initializers
  def order_confirmation(order)# accepting object order to mail it
    @order = order

    mail to: @order.user.email ,subject: "your order confirmation", cc: "pkpi1309@gmail.com"
  end
end
