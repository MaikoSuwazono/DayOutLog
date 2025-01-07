# サービス名：「DayOutLog」
[![Image from Gyazo](https://i.gyazo.com/6c791f2e1ca99c2a6cac251259e7bc69.png)](https://gyazo.com/6c791f2e1ca99c2a6cac251259e7bc69)

# サービス概要
休日の散歩から旅行まで、1日の外出記録を時系列形式でシェアできるアプリです。他のユーザーの計画を参考にしたり、友人同士で旅行の計画をする際に活用できます。

## 想定するユーザー層
・外出の際の行き先のアイデアを探している人
・自身の外出記録を発信することが好きな人

# サービスURL
**https://www.dayoutlog.com/**

# サービス開発のきっかけ
休日出かけようと思ってもどこに行くか思いつかないことがあり、その際他の人がどのように1日を過ごしたか分かれば参考になると思い、アプリを作成しようと思いました。
Instagramなどでお出かけ情報を投稿することができますが、どのような時系列でお出かけスポットを巡ったかまではわからないため、より具体的に1日の行動を参考にすることができます。

# サービスの機能
1. 投稿：時系列で投稿できることで、1日で巡れるお出かけスポットを知ることができます。
2. 検索機能：投稿タイトルや本文をもとに検索をして、情報収集することができます。
3. コメント、いいね機能：コメントやいいねをつけることで、ユーザー同士の交流ができたり、投稿者のモチベーションにもつながります。

# 技術スタック
| カテゴリ | 技術内容 |
| ------------- | ------------- |
|サーバーサイド|Ruby on Rails 7.1.4・Ruby 3.3.0|
|フロントエンド|Ruby on Rails・JavaScript|
|CSSフレームワーク|Bootstrap|
|Web API|Google API|
|データベースサーバー|PostgreSQL|
|ファイルサーバー|AWS S3|
|アプリケーションサーバー|Heroku|
|バージョン管理ツール|GitHub|

# 画面遷移図
https://www.figma.com/board/7V7c0nnhgSlGTXMmaMnzso/DayOutLog_%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=igdGUbic9eyGdRY6-1

# ER図
[![Image from Gyazo](https://i.gyazo.com/b4298a0e00e0c419d6cb3f70a222a585.png)](https://gyazo.com/b4298a0e00e0c419d6cb3f70a222a585)
