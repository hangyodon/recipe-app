## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|pass_word|integer|null: false|

### Association
- has_many :likes
- has_many :recipes


## likesテーブル

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
|sugar|decimal|null: false|

### Association
- belongs_to :user
- has_many :likes
- has_many :materials
- has_many :steps
- has_many :types
- hasmany :recipes_tags
- has_many :tags, through: :recipes_tags


## materialsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|amount|string|null: false|
|recipe_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :recipe


## stepsテーブル
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|process|string|null: false|
|recipe_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :recipe


## typesテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null: false|
|recipe_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :recipe


## tagsテーブル
|Column|Type|Options|
|------|----|-------|
|text|string|null :false|

### Association
- has_many :recipes_tags
- has_many :recipes, through: :recipes_tags


## recipes_tagsテーブル
|Column|Type|Options|
|------|----|-------|
|recipe_id|integer|null: false, foreign_key: true|
|tag_id|integer|null: false, foerign_key: true|

### Association
- belongs_to: recipe
- belomgs_to: tag



