class CommentsController < ApplicationController

  def new
    board = Board.find(params[:board_id])
    @comment = board.comments.build
    # @board = Board.find(params[:board_id])
    # @comment = @board.comments.build
  end

  # def edit
  #   @board = board.find(params[:board_id])
  #   @comment = Comment.find(params[:id])
  # end

  def edit
    @board = Board.find(params[:board_id])
    @comment = @board.comments.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    # コメントの更新処理
    if @comment.update(comment_params)
      redirect_to board_path(@comment.board_id), notice: 'コメントが更新されました'
    else
      render :edit
    end
  end

  def create
    board = Board.find(params[:board_id])
    @comment = board.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to board_path(board), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  # def destroy
  #   @board = Board.find(params[:board_id])
  #   @comment = current_user.comments.find_by(board_id: @board.id)
  #   @comment.destroy
  #   redirect_to board_path(params[:board_id]), notice: '削除に成功しました', status: :see_other
  # end

  def destroy
    @board = Board.find(params[:board_id])
    @comment = @board.comments.find_by(user_id: current_user.id)
  
    if @comment
      @comment.destroy
      redirect_to board_path(params[:board_id]), notice: 'コメントを削除しました'
    else
      redirect_to board_path(params[:board_id]), alert: 'コメントが見つかりません'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(board_id: params[:board_id])
  end

end
