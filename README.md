# codingirlsclub
## Install

* Ruby 版本
  1. `MRI 2.4` 建议版本 `2.4.1` 或以上版本

* 系统依赖
  1. `MySQL` => `brew install mysql`

* 配置文件(拷贝并编辑`.bk`文件)
    1. `config/database.yml`
    2. `config/application.yml`

* 初始数据导入
  1. 城市数据: `rake import:cities_from_json`
  2. 学校数据: `rake import:universities_from_json`

* 开发规则
  1. 遵循 [The Ruby Style Cuide](https://github.com/bbatsov/ruby-style-guide)

* 版本控制
  1. 使用 `git`
  2. 使用 `git-flow` 推荐流程， [git-flow](https://github.com/petervanderdoes/gitflow-avh)


css在vendor/assets/stylesheets目录下，公用的文件直接在这个目录下，前端私有的文件在frontend目录下; js文件vendor/assets/javascripts目录下，公用的文件直接在这个目录下，前端私有的文件在frontend目录下；
字体文件在 app/assets/fonts目录下