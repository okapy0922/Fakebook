class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    # 投稿時間順にしますの記述
    @topics = Topic.order(:created_at).reverse_order
  end

  # showアククションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topics_params)
    if @topic.save
      redirect_to topics_path, notice: "topicを作成しました！"
    else
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topics_params)
    if @topic.save
      redirect_to topics_path,　notice: "Topicを更新しました！"
    else
     render 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    @topics = Topic.all
    render  'index', notice:"Topicを削除しました！"
  end

  private
  def topics_params
    params.require(:topic).permit(:image, :content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
