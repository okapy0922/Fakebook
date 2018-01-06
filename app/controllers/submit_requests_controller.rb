class SubmitRequestsController < ApplicationController
  #　ログインしていないとタスク依頼機能が使用できない
  before_action :authenticate_user!
  before_action :set_submit_request, only: [:show, :edit, :update, :destroy, :approve, :reject]

  def index
    # 自分が送信した依頼のみ一覧に表示するようにする
    @submit_requests = SubmitRequest.where(user_id: current_user.id)
  end

  def new
    # タスクの依頼人のidがuser_idに入り保存されるようにする
    # buildメソッドを使用してuser_idが入ったタスク依頼のインスタンス(実体)(@submit_request)を作成。(newアクションの時点で、user_idを保持していないとコケるっぽい)
    @submit_request = current_user.submit_requests.build
  end

  def show
  end

  def edit
  end

  def create
    @submit_request = current_user.submit_requests.build(submit_request_params)

      respond_to do |format|
        if @submit_request.save
          format.html { redirect_to @submit_request, notice: 'Submit request was successfully created.' }
          format.json { render :show, status: :created, location: @submit_request }
        else
          format.html { render :new }
          # devise(ログイン機能)のcurrent_userメソッドとbuildメソッドを使用して、予め自分のuser_idが入ったタスク依頼のインスタンス(実体)(@submit_request)を作成。

          format.json { render json: @submit_request.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @submit_request.update(submit_request_params)
        format.html { redirect_to @submit_request, notice: 'Submit request was successfully updated.' }
        format.json { render :show, status: :ok, location: @submit_request }
      else
        format.html { render :edit }
        format.json { render json: @submit_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submit_request.destroy
    respond_to do |format|
      format.html { redirect_to submit_requests_url, notice: 'Submit request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # inboxメソッド: 自分にきているタスク依頼のみを取得し、インスタンス変数に格納する
  def inbox
    # ユーザのタスク一覧には依頼中のステータス(status: 1)のタスクのみ表示する
    @submit_requests = SubmitRequest.where(request_user_id: current_user.id).where(status: 1)
  end
  # タスク依頼承認の実行
  def approve
      if @submit_request.update(submit_request_params)
          @submit_request.task.update(charge_id: current_user.id)
            redirect_to inbox_submit_requests_path, notice: '依頼を承認しました。'
      else
            redirect_to inbox_submit_requests_path, notice: '不具合が発生しました、もう一度操作を行ってください。'
      end
  end

  # タスク依頼却下の実行
  def reject
      if @submit_request.update(submit_request_params)
        redirect_to inbox_submit_requests_path, notice: '依頼を却下しました。'
      else
        redirect_to inbox_submit_requests_path, notice: '不具合が発生しました、もう一度操作を行ってください。'
      end
  end

  private
    def set_submit_request
      @submit_request = SubmitRequest.find(params[:id])
    end

  def submit_request_params
    # ストロングパラメーター、hoge_idを入れる(これがないと入力した状態がviewに渡らない)
    params.require(:submit_request).permit(:request_user_id, :task_id, :user_id, :charge_id, :status, :message)
  end
end
