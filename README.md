# codingirlsclub
## Install

* Ruby 版本
  1. `MRI 2.3` 建议版本 `2.3.1` 或以上版本

* 系统依赖
  1. `MySQL` => `brew install mysql`

* 配置文件(拷贝并编辑`.bk`文件)
    1. `config/database.yml`

* 初始数据导入
  1. 城市数据: `rake import:cities_from_json`
  2. 学校数据: `rake import:universities_from_json`

* 开发规则
  1. 遵循 [The Ruby Style Cuide](https://github.com/bbatsov/ruby-style-guide)

* 版本控制
  1. 使用 `git`
  2. 使用 `git-flow` 推荐流程， [git-flow](https://github.com/petervanderdoes/gitflow-avh)

