# frozen_string_literal: true

##
# Top level mailer
#
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
