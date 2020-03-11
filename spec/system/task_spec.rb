require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, name: 'task', progress: '完了')
    FactoryBot.create(:task, name: '付け加えた名前１')
    FactoryBot.create(:task, name: '付け加えた名前２')
    FactoryBot.create(:second_task, name: '付け加えた名前３', detail: '付け加えたコンテント')
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
        new_task = FactoryBot.create(:task, name: 'new_task')
        visit tasks_path
        # save_and_open_page
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content '付け加えた名前３'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path

        fill_in "task_name", with: "abcdef"
        fill_in "task_detail", with: "ghijkl"
        click_on "登録する"

        expect(page).to have_content "abcdef"
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
      task = FactoryBot.create(:task, name: 'wwwww')
       it '該当タスクの内容が表示されたページに遷移すること' do
         visit task_path(task)
         save_and_open_page
         expect(page).to have_content "wwwww"
       end
     end
  end

  describe 'タスク一覧' do
    context '最終期限ボタンを押したら' do
      before do
        # 1 全てのタスクを取得してdeadlineを一日置きになる様に設定する
        all_tasks = Task.all
        all_tasks.each_with_index do |task, i|
          task.deadline = Date.today + i
          task.save
        end
      end
      it '期日が迫っている日から見せまた、progressが登録されている' do
        visit tasks_path
        # 2 ボタンを押す
        click_on "終了期限でソートする"
        # 3 評価する
        sleep 3
        save_and_open_page

        # expect(page).to have_content 0
      end
    end
  end

  describe 'タスク一覧' do
    context '進捗Progress検索で、完了、を指定後、検索を押したら' do
    it '完了タスクだけ表示' do
        visit tasks_path
        all_tasks = Task.all
        find("option[value='2']").select_option     

        click_on "検索"

        sleep 3
        save_and_open_page
      end
    end
  end

  describe 'タスク一覧' do
    context 'タスク名Name検索で、付け加えた名前１、を指定後、検索を押したら' do
    it 'タスク名、付け加えた名前１、だけを表示' do
        visit tasks_path
        all_tasks = Task.all
        # input[value] = "付け加えた名前１"
        # <input type="submit"> = "付け加えた名前１"
        
        fill_in "task_name", with: "付け加えた名前１"
        click_on "検索"
        
        sleep 3
        save_and_open_page
      end
    end
  end

end
