require "sinatra"

# Cria o contrato
class Notifier
  def send(message)
    raise NotImplementedError 
  end
end

# Implementa o contrato 
class EmailNotifier < Notifier 
  def send(message)
    "Email: #{message} enviado"
  end
end

# Cria o creator
class NotifierCreator 
  def send_notification(message)
    notifier = create_notifier
    notifier.send(message)
  end

  def create_notifier
    raise NotImplementedError
  end
end

# Implementa o creator 
class EmailSender < NotifierCreator 
  def create_notifier 
    EmailNotifier.new 
  end
end

post "/notify" do
  content_type :json
  message = params["message"]
  
  sender = EmailSender.new
  resultado = sender.send_notification(message)

  { status: "email notificado", message: resultado }.to_json
end
