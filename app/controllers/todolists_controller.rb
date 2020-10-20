class TodolistsController < ApplicationController
  def new
    # 空のモデルを生成し、Viewのform_withの引数に渡す
    @list = List.new
  end
  def create
    # listインスタンスを生成し、title, bodyに値をセット
    list = List.new(list_params)
    list.save
    redirect_to todolist_path(list.id)
  end
  def index
    # List.allメソッドで、listsテーブルから全てのデータを配列で取得
    @lists = List.all
  end
  def show
    # URLの「:id」の値が、paramsという変数にハッシュとして入る。params[:id] と記述してID取得
    @list = List.find(params[:id])
  end
  def edit
    # データベースから編集したい投稿を取得
    @list = List.find(params[:id])
  end
  def update
    # 更新する投稿データをデータベースから取り出す
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to todolist_path(list.id)  
  end
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to todolists_path
  end

  private
  def list_params
    # paramsはRailsで送られてきた値を受け取るためのメソッド
    # requireでデータのオブジェクト名を指定し、permitでキー（:title,:body）を指定
    params.require(:list).permit(:title, :body, :image)
  end
end
