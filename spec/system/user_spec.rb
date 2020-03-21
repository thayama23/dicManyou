require 'rails_helper'
RSpec.describe '新規登録・ログイン画面', type: :system do
    before do
        # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
        # 各テストで使用するタスクを1件作成する
        # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
        # @task = FactoryBot.create(:task, name: 'task', progress: '完了')
        FactoryBot.create(:user)
        FactoryBot.create(:second_user)   
    end

    describe '新規登録画面' do
      context '必要項目を入力して、登録するボタンを押した場合新規登録される' do
        it "新規登録完了" do
          visit new_user_path
          fill_in 'user_name', with: 'me'
          fill_in 'user_email', with: 'me@example.com'
          fill_in 'user_password', with: 'me@example.com'
          fill_in 'user_password_confirmation', with: 'me@example.com'
          # fill_in 'admin', with: true
          click_button 'Create my account'
          # sleep 3
          visit user_path(User.last.id)
          expect(page).to have_content('meのページ')
          # save_and_open_page
        end
        it "ユーザーがログインしていないのにタスク一覧のページに飛ぼうとした場合ログイン画面に遷移するこ" do
          visit new_user_path
          expect(page).to have_content('新規ユーザー登録かログインして下さい!')
        end
        it "自分の詳細画面(マイページ)に飛べること" do
          visit new_user_path
          fill_in 'user_name', with: 'me'
          fill_in 'user_email', with: 'me@example.com'
          fill_in 'user_password', with: 'me@example.com'
          fill_in 'user_password_confirmation', with: 'me@example.com'
          click_button 'Create my account'
          visit user_path(User.last.id)
          expect(page).to have_content('meのページ')
        end
        it "一般ユーザーが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
          visit new_user_path
          fill_in 'user_name', with: 'me'
          fill_in 'user_email', with: 'me@example.com'
          fill_in 'user_password', with: 'me@example.com'
          fill_in 'user_password_confirmation', with: 'me@example.com'
          click_button 'Create my account'
          visit user_path(User.first.id)
          expect(page).to have_content('他の人のページへアクセスは出来ません!')
        end
        it "ログアウトができること" do
          visit new_user_path
          fill_in 'user_name', with: 'me'
          fill_in 'user_email', with: 'me@example.com'
          fill_in 'user_password', with: 'me@example.com'
          fill_in 'user_password_confirmation', with: 'me@example.com'
          click_button 'Create my account'
          click_link 'Logout'
          save_and_open_page
          sleep 3
          expect(page).to have_content('Log in')
        end
      end
    end

    # describe '管理画面のテスト' do
    #   context '管理者がいること' do
    #     it "ログアウトができること" do
    #       visit new_session_path
    #       fill_in "session_email", with: ""
    #       fill_in "session_password", with: ""
    #       sleep 1
    #       save_and_open_page
    #       fill_in "session_email", with: "tester1@example.com"
    #       fill_in "session_password", with: "00000000"
    #       save_and_open_page
    #       click_button 'Log in'
    #       save_and_open_page
    #       # expect(page).to have_content('Logout')
    #       # sleep 3
    #       # expect(page).to have_content('タスク一覧')
    #     end
    #   end
    # end

    # describe '既存ユーザーログイン' do
    #   context '必要項目を入力、log inボタン押した後' do
    #     it "ログイン完了、そしてマイページにも移動出来、またログアウトも確認" do
    #       FactoryBot.create(:user)
    #       FactoryBot.create(:second_user)  
    #       visit new_session_path
    #       fill_in 'session[email]', with: 'tester1@example.com'
    #       fill_in 'session[password]', with: '00000000'
    #       click_button 'Log in'
    #       save_and_open_page
    #       # expect(page).to have_content('Logout')
    #       # sleep 3
    #       # expect(page).to have_content('タスク一覧')

    #       # sleep 3
    #       # click_button 'Profile'
    #       # expect(page).to have_content('tester1のページ')

    #       # sleep 3
    #       # click_button 'Logout'
    #       # expect(page).to have_content('ログアウトしました')
    #     end
    #   end
    # end    


    # describe '既存ユーザーログイン' do
    #   context '必要項目を入力、log inボタン押した後' do
    #     it "ログイン完了、そしてマイページにも移動出来、またログアウトも確認" do
    #       visit new_session_path
          
    #       fill_in 'email', with: 'tester1@example.com'
    #       fill_in 'password', with: 'tester1@example.com'
    #       click_button 'Log in'

    #       sleep 3
          
        


    #     end
    #   end
    # end

    # describe '管理者専用・ユーザー一覧' do
    #   context '管理者権限付与者がログインした場合,管理者専用管理者専用・ユーザー一覧' do
    #     it "へ,ログイン出来・閲覧可能" do
    #       user = FactoryBot.create(:second_user)
    #       visit admin_users_path
          
    #       expect(page).to have_content('管理画面のユーザー一覧画面')
    #     end

    #     it "内で,　新規ユーザー作成が出来る" do
    #       fill_in 'user_name', with: 'you'
    #       fill_in 'user_email', with: 'you@example.com'
    #       fill_in 'user_password', with: 'you@example.com'
    #       fill_in 'user_password_confirmation', with: 'you@example.com'
    #       fill_in 'admin', with: false
    #       click_button 'Create my account'
    #       expect(page).to have_content('youのページ')
    #     end

    #     it "内で,　既存ユーザーの編集が出来る" do
    #       visit admin_users_path
    #       click_button 'Destroy'
    #       fill_in 'user_email', with: 'new_you@example.com'
    #       click_button 'Create my account'
    #       expect(page).to have_content('ユーザー詳細を編集しました！')
    #     end

    #     it "内で,　既存ユーザーの削除が出来る" do
    #       click_button 'Destroy'
    #       expect(page).to have_content('ユーザー詳細を編集しました！')
    #     end        
    #   context '必要項目を未記入で登録するボタンを押した場合新規登録されない' do
    #   end
    # end

end