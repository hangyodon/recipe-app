[![Image from Gyazo](https://i.gyazo.com/cfcc4cb96fefc519b90b9cd7d1d19693.jpg)](https://gyazo.com/cfcc4cb96fefc519b90b9cd7d1d19693)


## 🌐 App URL
### **https://intense-citadel-88320.herokuapp.com/**
　　
　　
## 📦 Features
カロリーや糖質を気にしている方に優しい投稿型のレシピアプリです。  
レシピ、つくれぽ、コメントの投稿・お気に入り登録ができます。  
  
  
## 💬 Why
普段料理をするときにレシピサイトを利用するのですが  
カロリー表記が分かりづらかったり、糖質の表記がないことが多く  
ダイエット中のレシピ検索に困っていました。  
  
そこで、カロリーと糖質が一目でわかるレシピアプリの開発を考えました。
  
  
  

## 🌈 plan
・　つくれぽ、コメントに対する返信機能をつける  
・　材料のカロリー、糖質の検索をアプリ内で可能にする　　
  
  
## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, dependent: :destroy|
|pass_word|integer|null: false|

### Association
- has_many :recipes, dependent: :destroy
- has_many :favorites, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :reports, dependent: :destroy



## favoritesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|recipe_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :recipe


## recipesテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|image|string|null: false|
|calorie|integer|null: false|
|sugar|string|null: false|
|category|string|null: false|
|user_id|integer|null: false|

### Association
- belongs_to :user
- has_many :favorites, dependent: :destroy
- has_many :materials, foreign_key: "recipe_id", dependent: :destroy
- has_many :steps, foreign_key: "recipe_id", dependent: :destroy
- has_many :comments, dependent: :destroy
- hasmany :reports, dependent: :destroy



## materialsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|amount|string|null: false|
|recipe|references|foreign_key: true|

### Association
- belongs_to :recipe, optional: true


## stepsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|process|string|null: false|
|recipe|references|foreign_key: true|

### Association
- belongs_to :recipe, optional: true


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|forein_key: true|
|recipe|references|foreign_key: true|
|text|text|null :false|


### Association
- belongs_to :recipe
- belongs_to :user


## reportsテーブル
|Column|Type|Options|
|------|----|-------|
|recipe|references|foreign_key: true|
|user|references|foerign_key: true|
|text|text|null: false|
|image|string|null: false|

### Association
- belongs_to: recipe
- belongs_to: user



