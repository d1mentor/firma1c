class SendFormMailer < ApplicationMailer
    default from: "gerasimenkot92@gmail.com"

    def send_form
        @name = params[:name]
        @email = params[:email]
        @message = params[:message]
        mail(to: ["gerasimenkot92@gmail.com", "gerasimenko1305@gmail.com"], subject: "profistyle.group контактная форма")
    end
end
