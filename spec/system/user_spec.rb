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

          sleep 3
          visit user_path(User.last.id)
          
          expect(page).to have_content('meのページ')
          save_and_open_page
        end
      end
    end

    describe '管理者専用・ユーザー一覧' do
      context '管理者権限付与者がログインした場合,管理者専用管理者専用・ユーザー一覧' do
        it "へ,ログイン出来・閲覧可能" do
          user = FactoryBot.create(:second_user)
          visit admin_users_path
          
          expect(page).to have_content('管理画面のユーザー一覧画面')
        end

        it "内で,　新規ユーザー作成が出来る"
          fill_in 'user_name', with: 'you'
          fill_in 'user_email', with: 'you@example.com'
          fill_in 'user_password', with: 'you@example.com'
          fill_in 'user_password_confirmation', with: 'you@example.com'
          fill_in 'admin', with: false
          click_button 'Create my account'
          expect(page).to have_content('youのページ')
        end

        it "内で,　既存ユーザーの編集が出来る"
          fill_in 'user_email', with: 'new_you@example.com'
          click_button 'Create my account'
          expect(page).to have_content('ユーザー詳細を編集しました！')
        end

        it "内で,　既存ユーザーの削除が出来る"
          click_button.(User.last.id) 'Destroy'
          expect(page).to have_content('ユーザー詳細を編集しました！')
        end        

        

      # context '必要項目を未記入で登録するボタンを押した場合新規登録されない' do
      #   it "ユーザー名が未記入のとき" do
      #     visit signup_path
      #     fill_in 'ユーザー名', with: ''
      #     fill_in 'メールアドレス', with: 'tester@example.com'
      #     fill_in 'パスワード', with: 'password'
      #     fill_in 'パスワード（確認）', with: 'password'
      #     click_button '登録する'
      #     expect(page).to have_content('ユーザー名を入力してください')
      #   end
      #   it "メールアドレスが未記入のとき" do
      #     visit signup_path
      #     fill_in 'ユーザー名', with: 'tester'
      #     fill_in 'メールアドレス', with: ''
      #     fill_in 'パスワード', with: 'password'
      #     fill_in 'パスワード（確認）', with: 'password'
      #     click_button '登録する'
      #     expect(page).to have_content('メールアドレスを入力してください')
      #   end
      #   it "パスワードは6文字以上で入力されていないとき" do
      #     visit signup_path
      #     fill_in 'ユーザー名', with: 'tester'
      #     fill_in 'メールアドレス', with: 'tester@example.com'
      #     fill_in 'パスワード', with: 'pass'
      #     fill_in 'パスワード（確認）', with: 'hoge'
      #     click_button '登録する'
      #     expect(page).to have_content('パスワードは6文字以上で入力してください')
      #   end
      #   it "確認用パスワードとパスワードの入力が一致しないとき" do
      #     visit signup_path
      #     fill_in 'ユーザー名', with: 'tester'
      #     fill_in 'メールアドレス', with: 'tester@example.com'
      #     fill_in 'パスワード', with: 'password'
      #     fill_in 'パスワード（確認）', with: 'hogehoge'
      #     click_button '登録する'
      #     expect(page).to have_content('パスワード（確認）とパスワードの入力が一致しません')
      #   end
      #   it "メールアドレスがすでに存在しているとき" do
      #     user = FactoryBot.create(:user)
      #     visit signup_path
      #     fill_in 'ユーザー名', with: 'tester'
      #     fill_in 'メールアドレス', with: 'tester@example.com'
      #     fill_in 'パスワード', with: 'password'
      #     fill_in 'パスワード（確認）', with: 'password'
      #     click_button '登録する'
      #     expect(page).to have_content('メールアドレスはすでに存在します')
      #   end
      # end
      # context 'ログイン画面で必要項目を入力して、ログインボタンを押した場合' do
      #   it "ログインされること" do
      #     user = FactoryBot.create(:user)
      #     visit login_path
      #     fill_in 'メールアドレス', with: user.email
      #     fill_in 'パスワード', with: user.password
      #     click_button 'ログインする'
      #     expect(page).to have_content('ログインしました。')
      #   end
      # end
      # context '最後の一人の管理者を削除できない' do
      #   it "削除できない" do
      #     admin = FactoryBot.create(:admin)
      #     visit login_path
      #     fill_in 'メールアドレス', with: admin.email
      #     fill_in 'パスワード', with: admin.password
      #     click_button 'ログインする'
      #     click_link('ユーザー一覧')
      #     click_link('削除')
      #     page.driver.browser.switch_to.alert.accept
      #     expect(page).to have_content('管理者権限者がいなくなるので削除できません')
      #   end
      end
    end


  end