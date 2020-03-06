require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, title: 'task')
  end

  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task, title: '付け加えた名前１')
    FactoryBot.create(:task, title: '付け加えた名前２')
    FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント')
  end 



  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # beforeに必要なタスクデータが作成されるので、ここでテストデータ作成処理を書く必要がない
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end
    end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path

        fill_in "task_task_name", with: "abcdef"
        fill_in "task_task_detail", with: "ghijkl"
        click_on "登録する"

        expect(page).to have_content "abcdef"

    end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
      task = FactoryBot.create(:task, task_name: 'wwwww')
       it '該当タスクの内容が表示されたページに遷移すること' do

       visit task_path(task)
       save_and_open_page
       expect(page).to have_content "wwwww"
     end
     end
  end
end
