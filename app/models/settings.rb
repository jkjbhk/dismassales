#implementation of the design item 8 -­ Paypal payment

class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end