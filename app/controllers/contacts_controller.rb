class ContactsController < ApplicationController

  def index
    @contacts = Contact.all#テーブルにある全てのデータを取得
  end

  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      # 一覧画面へ遷移して"お問い合わせありがとうございます！"とメッセージを表示します
      redirect_to new_contact_path, notice: "お問い合わせありがとうございます！"
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
      render :new if @contact.invalid?
    end
  end

private
  def contacts_params
    params.require(:contact).permit(:name, :email, :content)
  end
