require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validation" do
    it 'nameが空ならバリデーションが通らない' do
      task = Task.new(name: '', detail: 'aaaa')
      expect(task).not_to be_valid
    end
    it 'detailが空ならバリデーションが通らない' do
      # ここに内容を記載する
      task = Task.new(detail: '', name: 'aaaa')
      expect(task).not_to be_valid
    end
    it 'nameとdetailに内容が記載されていればバリデーションが通る' do
      @user = FactoryBot.create(:user)
      task = FactoryBot.create(:task, user: @user)
      expect(task).to be_valid

      # step-5でのコメント - Modelのテストだから、viewに飛んでloginしてテストをすると言う概念はないから下記は間違い。
      # visit new_session_path
      #   fill_in 'session[email]', with: 'sample@example.com'
      #   fill_in 'session[password]', with: '00000000'
      #   click_button 'Log in'

      #   task = Task.new(
      #   name: 'hoge',
      #   detail: 'hogehoge'
      #   user: @user
      # )
    end
  end

  # describe ".admins" do
  #   it "includes users with admin flag" do
  #     admin = User.create!(admin: true)
  #     expect(User.admins).to include(admin)
  #   end

  #   it "excludes users without admin flag" do
  #     non_admin = User.create(admin: false)
  #     expect(User.admins).not_to include(non_admin)
  #   end

  describe "scope" do
    it 'to include task_name, aaaaa' do
      # task_name = Task.new(name: "aaaaa", detail: "bbbbb", progress: "完了", user: @user)
      @user = FactoryBot.create(:user)
      task = FactoryBot.create(:task, name: "aaaaa", detail: "aaaaa", user: @user)
      # binding.irb
      # expect(Task.search_name("aa")).to include Task.find_by(name: "aaaaa")
      expect(Task.search_name("aaaaa").count).to eq 1
    end

    it 'to include task_progress, 完了' do
      @user = FactoryBot.create(:user)
      task_progress = Task.create(name: "aaaaa", detail: "bbbbb", progress: 2, user: @user)

      expect(Task.search_progress( 2 ).count).to eq 1
    end
  end
  # it 'nameが空ならバリデーションが通らない' do
  #   task = Task.new(name: '', detail: 'aaaa')
  #   expect(task).not_to be_valid
  # end
  # it 'detailが空ならバリデーションが通らない' do
  #   # ここに内容を記載する
  #   task = Task.new(detail: '', name: 'aaaa')
  #   expect(task).not_to be_valid
  # end
  # it 'nameとdetailに内容が記載されていればバリデーションが通る' do
  #   # ここに内容を記載する
  #   task = Task.new(
  #     name: 'hoge',
  #     detail: 'hogehoge'
  #   )
  #   expect(task).to be_valid
  # end

  # it 'progressとpriorityに内容が記載されていればバリデーションが通る' do
  #   # ここに内容を記載する
  #   task = Task.new(
  #     progress: 無関係, 
  #     priority: 無関係
  #   )
  #   expect(task).not_to be_valid
  #   # expect(task).to be_valid
  # end
end
