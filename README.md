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

## Herokuへのデプロイ手順

- アセットコンパイル(アセットの圧縮)
```sh
$ rails assets:precompile RAILS_ENV=production
```

- ファイルをステージングエリアへ
```sh
$ git add .
$ git commit -m "コミットメッセージ"
$ git push origin <ブランチ名>
```
- Herokuへデプロイ
```sh
$ heroku create
$ git remote -v #デプロイしたいアプリとherokuが繋がっている事を確認
$ git push heroku <ブランチ名>
$ heroku run rails db:migrate #Herokuへデーベースの移行
```
