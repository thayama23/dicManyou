require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        task = FactoryBot.create(:task, task_name: 'task')

        visit tasks_path
        expect(page).to have_content 'task'
      end
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