# User テーブル
* name  (name:string)
* email  (email:string)
* password  (password:string)
* password_confirm  (password_confirm:string)

# Task テーブル
* name  (name:string)
* detail  (detail:text)

# Label テーブル
* name (name:string)

# Herokuへのデプロイ手順
|する事|コマンド|メモ|
|:—————|:——————:|:——————:|
|アセットコンパイル|Asset compile rails assets:precompile RAILS_ENV=production|アセットの圧縮｜
|ファイルをステージングエリアへ| : $ git add . ||
|コメント付でブランチへファイルのコミット|$ git commit -m ”コメントを入れる”|何をしたかわかりやすいコメント付ける|
|Gitへpush|$ git push origin master|或いはサブブランチへpush, その際はmasterではなくサブブランチ名を使う|
|Herokuへログイン|$ heroku login||
|Herokuへ新アプリケーションの作成|$ heroku create|この時ターミナルで必ずデプロイしたいアプリケーションにいる事を確認|
|関連確認|$ git remote -v|デプロイしたいアプリとherokuが繋がっている事を確認|
|Herokuへデプロイ|$ git push heroic master|サブブランチへデプロイしたい場合はmasterではなく、サブブランチ名を使用|
|Herokuへデーベースの移行|$ heroku run rails db:migrate||
=======
# README

* User テーブル
  -name  (name:string)
  -email  (email:string)
  -userid  (userid:integer) 
  -password  (password:string)
  -password_confirm  (password_confirm:string)
    
 
* Task テーブル
  -task_name  (task_name:string)
  -task_detail  (task_detail:text)
  -deadline  (deadline:date)

* Label テーブル
  -priority 重要度 (priority:string)
  -category 種別  (category:string)
