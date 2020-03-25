require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    # @task = FactoryBot.create(:task, name: 'task', progress: '完了')
    # FactoryBot.create(:task, name: '付け加えた名前1')
    # FactoryBot.create(:task, name: '付け加えた名前２')
    # FactoryBot.create(:second_task, name: '付け加えた名前3', detail: '付け加えたコンテント')

    Label.create(name: "プライベート")
    Label.create(name: "仕事")
    @label3 = Label.create(name: "家族")
    
    @user = FactoryBot.create(:user)
     FactoryBot.create(:task, name: '付け加えた名前1', detail: '付け加えたコメント1', progress: '完了', user: @user)
    # FactoryBot.create(:task, name: '付け加えた名前２', detail: '１2', user: @user)
    @task2 = FactoryBot.create(:second_task, name: '付け加えた名前3', detail: '付け加えたコメント3', user: @user)
    Labelling.create(task_id: @task2.id, label_id: @label3.id)
  end

  def login
    visit new_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "00000000"
    click_on "Log in"
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # beforeに必要なタスクデータが作成されるので、ここでテストデータ作成処理を書く必要がない
        login
        visit tasks_path
        expect(page).to have_content '付け加えた名前1'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        
        login
        visit tasks_path
        # new_task = FactoryBot.create(:task, name: 'new_task')
        # save_and_open_page
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく

        expect(task_list[0]).to have_content '付け加えた名前3'
        expect(task_list[1]).to have_content '付け加えた名前1'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        login
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
       it '該当タスクの内容が表示されたページに遷移すること' do
        login
        task = FactoryBot.create(:task, name: 'wwwww', detail: 'xxxx', user: @user)
         visit task_path(task)
         save_and_open_page
         expect(page).to have_content "wwwww"
       end
     end
  end

  describe 'タスク一覧' do
    context '最終期限ボタンを押したら' do
      
      before do
        login
        # 1 全てのタスクを取得してdeadlineを一日置きになる様に設定する
        all_tasks = Task.all
        all_tasks.each_with_index do |task, i|
          task.deadline = Date.today + i
          task.save
        end
       end

      it '期日が迫っている日から見せまた、progressが登録されている' do
        login
        visit tasks_path
        # 2 ボタンを押す
        click_on "終了期限でソートする"
        # 3 評価する
        sleep 3
        save_and_open_page
        expect(page).to have_text /.*付け加えたコメント1.*付け加えたコメント3.*/m
        # expect(page).to have_content 0
      end
    end
  end

  describe 'タスク一覧' do
    context '進捗状態で完了、を指定後、検索を押したら' do
    it '完了タスクだけ表示' do
        login
        visit tasks_path
        all_tasks = Task.all
        
        find('#task_progress').find("option[value='2']").select_option  
        # find(:css, "#task_progress[value='2']").select_option ..this didnt work.
        # find('#organizationSelect').find(:xpath, 'option[2]').select_option .. this worked!

        click_on "検索"

        sleep 3
        save_and_open_page
        expect(find("tbody").text).to have_content "完了"
        expect(find("tbody").text).not_to have_content "着手中"
        expect(find("tbody").text).not_to have_content "未着手"
      end
    end
  end

  describe 'タスク一覧' do
    context 'タスク名Name検索で、付け加えた名前1、を指定後、検索を押したら' do
    it 'タスク名、付け加えた名前1、だけを表示' do
        login
        visit tasks_path
        all_tasks = Task.all
        # input[value] = "付け加えた名前1"
        # <input type="submit"> = "付け加えた名前1"
        
        fill_in "task_name", with: "付け加えた名前1"
        click_on "検索"
        
        sleep 3
        save_and_open_page

        expect(find("tbody").text).to have_content "付け加えた名前1"

      end
    end
  end

  describe 'タスク一覧' do
    context '新規タスク作成時、ラベル付け' do
      it 'プラーベート、仕事、家族と複数ラベル表示' do
        login
        visit tasks_path
        click_on "New Task"
        
        fill_in "タスク名", with: "abcde"
        fill_in "タスク詳細", with: "fghij"
        # この記述方法でテスト環境で作ったラベル全てをクリックする方法
        find(:css, "#task_label_ids_1[value='1']").set(true)
        find(:css, "#task_label_ids_2[value='2']").set(true)
        find(:css, "#task_label_ids_3[value='3']").set(true)
      
        click_on "登録する"
        sleep 3
        click_on "Back"
        
        # find(:css, "#cityID[value='62']").set(true)
        sleep 3

        expect(page).to have_content "プライベート 仕事 家族"
      end 
    end

    context '家族、でラベル検索' do
      it '家族タグ付のタスクだけを閲覧' do
      login
      visit tasks_path

      find('#label_id').find("option[value='3']").select_option   
      # save_and_open_page

      # binding.irb
      click_on "Search"

      sleep 3
      # save_and_open_page

      expect(page).to have_text /.*付け加えたコメント3.*家族.*/m      
      end
    end
  end
end
