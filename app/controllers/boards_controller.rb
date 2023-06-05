class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments
    # 他の必要なコード
  end

  def new
    @board = current_user.boards.build
  end

  # データの枠を作り、もしデータを保存できたらそのページに飛ぶ、できなかったら
  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path(@board.id), notice: '保存されています'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: '削除に成功しました', status: :see_other
  end

  # フォームからの投稿データからタイトルと内容を抜き出す
  private
  def board_params
    params.require(:board).permit(:title, :content, :eyecatch)
  end

  def set_board
    puts "params[:id]: #{params[:id]}"
    @board = Board.find(params[:id])
    puts "@board: #{@board.inspect}"
  end
end