Rails.application.routes.draw do

  get 'notifications/index'

  resources :blogs do # blogsのrouting
    resources :comments
    collection do
      post :confirm
    end
  end

  resources :contacts, only: [:new, :create] do # contactsのrouting
    collection do
      post :confirm
    end
  end

  # SNSログイン,ルーティング定義の追加
  # 新規登録する際に、継承したregistration_controllerが
  # 使用されるようにする

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # フォロー機能
  # ユーザー一覧ページを作成する
  # devise_for より下に記述する必要がある(ルーティングがログイン後のマイページになってしまう)
  # 不要なrouting get 'users/index'を削除、routingをresourcesへ書き直し 2017.11/11
  resources :users, only: [:index, :show]
  # タスク管理機能 タスクを作成するcreateアクションとタスクを削除するdestroyアクションへのroutingを作成
  resources :tasks
  # タスク依頼を受信する一覧ページのrouting作成
  resources :submit_requests do
    # submit_request/inboxというrouting
    get 'inbox', on: :collection
    # 依頼受信ページからタスク依頼に対して、承認と却下ができるようにする
    member do
      patch 'approve'
      patch 'reject'
    end
  end

  # フォローをする、やめるの機能のルーティング（フォロー関係を作成するcreateアクションと削除するdestroyアクションへのroutingを作成）
  resources :relationships, only: [:create, :destroy]

  # メッセージ機能のrouting、conversations内にmessagesがネストされたものを定義
  resources :conversations do

    resources :messages

  end


  # トップページ
  root 'top#index'

  # 11_メール送信
  # 開発環境だとメールを送れない
  # 発信したかどうかを確認するツールを利用できるようにする
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
