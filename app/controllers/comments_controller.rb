class CommentsController < ApplicationController
  before_action :authenticate_user!
  # コメントを保存、投稿するためのアクションです。
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # コメント投稿の際に、Notificationが作成されるようcomments#createに@notificationを定義
    # commentに紐付いた、notificationを作成　user_idを保存する(user_id: @blog.user_id)
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    # respond_toは、クライアントからの要求に応じてレスポンスのフォーマットを変更します。
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        # JS形式でレスポンスを返します。(JSの画面更新による処理で動的処理が実現する)
        format.js { render :index }
        # コメントしたユーザと、ログインしているユーザのidが同じだった場合、通知がこないようにする
        unless @comment.blog.user_id == current_user.id
          # ブログの作成者に「◯◯にコメントが投稿されました！」とポップアップされる
          # test_channel(channel)のcomment_created(event)でpusherに送信する messageという変数に、コメントが投稿された旨を代入し、それも送信
          # Pusher.trigger('test_channel', 'comment_created', {
          # "user-#{@comment.blog.user_id}_channel"とすることで、blogを作成したuserへのchannelを作る
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        # コメントを投稿した際にヘッダーの通知件数がリアルタイムで更新されるようにする
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          uncreate_count: Notification.where(user_id: @comment.blog.user.id).count

        })
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
  end

      def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        render :json => {:comment => @comment} # JS形式でレスポンスを返します。(JSの画面更新による処理で動的処理が実現する)

      end

      private
      # ストロングパラメーター
      def comment_params
        params.require(:comment).permit(:blog_id, :content)
      end
    end
