class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    # デプロイしたら自分のメールアドレスに変更
    # .envを使用して自分のメールアドレスを公開しないように
    mail(to: 'text@test.com', subject: 'お問い合わせ内容')
  end
end
