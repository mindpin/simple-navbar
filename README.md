simple-navbar
=============

a simple navbar plugin

[![Build Status](https://travis-ci.org/mindpin/simple-navbar.png?branch=master)](https://travis-ci.org/mindpin/simple-navbar)
[![Coverage Status](https://coveralls.io/repos/mindpin/simple-navbar/badge.png?branch=master)](https://coveralls.io/r/mindpin/simple-navbar)
[![Code Climate](https://codeclimate.com/github/mindpin/simple-navbar.png)](https://codeclimate.com/github/mindpin/simple-navbar)

## Install
include in Gemfile:

```bash
gem 'simple-navbar'
```

## Config

```bash
rails g simple_navbar_config config
```

## Usage

in simple_navbar_config.rb

```ruby
SimpleNavbar::Base.config do
  rule :simple do
    nav :index, :name => '首页', :url => '/' do
      # 当 controler 是 index_controller, action 是 index
      # 当前 nav 被选中
      controller :index, :only => :index

      # only 参数支持数组形式
      # controller :index, :only => [:index]
      # 同时还支持 except 参数
      # controller :index, :except => [:index]
      # controller :index, :except => :index
    end

    nav :books, :name => '书籍', :url => '/books' do
      # 当 controler 是 books_controller
      # 当前 nav 被选中
      controller :books
    end

    nav :movies, :name => '电影', :url => '/movies' do
      controller :movies
    end

    nav :musics, :name => '音乐', :url => '/musics' do
      controller :musics
    end
  end

  rule :multi_level_example do
    nav :index, :name => '首页', :url => '/' do
      controller :index, :only => :index
    end

    nav :movies, :name => '电影', :url => '/movies' do
      controller :movies
    end

    nav :musics, :name => '音乐', :url => '/musics' do
      # 一个 nav 下支持配置多个 controller
      controller :musics
      controller :pop_musics
      controller :rock_musics
      controller :punk_musics 

      nav :pop_musics, :name => '流行音乐', :url => '/musics/pop' do
        controller :pop_musics
        controller :rock_musics
        controller :punk_musics 
        # nav 支持任意层级的嵌套
        nav :rock_musics, :name => '摇滚音乐', :url => '/musics/pop/rock' do
          controller :rock_musics
          controller :punk_musics 

          nav :punk_musics, :name => '朋克', :url => '/musics/pop/rock/punk' do
            controller :punk_musics 
          end
        end

      end
    end
  end

  # 可以同时配置多个 rule
  rule [:rule_1, :rule_2] do
    nav :index, :name => '首页', :url => '/' do
      controller :index, :only => :index
    end

    nav :books, :name => '书籍', :url => '/books' do
      controller :books
    end

    nav :movies, :name => '电影', :url => '/movies' do
      controller :movies
    end

    nav :musics, :name => '音乐', :url => '/musics' do
      controller :musics
    end
  end

  rule :admin do
    nav :index, :name => '首页', :url => '/admin' do
      # 支持带 namespace 的 controller
      controller :'admin/index'
    end
  end

end

```

in view
```haml
 # haml
 
 # simple_navbar is a helper method
 # :admin is a rule_name
 = simple_navbar(:admin)
```


## i18n support

### 没有使用 i18n 
在没有使用 i18n 时的配置如下
```
rule :admin do
  nav :courses, :name => '课程管理', :url => '/admin/courses' do
    controller :'admin/courses'
    nav :import, :name => ‘课程导入’, :url => '/admin/courses/import' do
      controller 'admin/courses', :only => [:import]
    end
  end
end
```

### 使用 i18n 
如果希望 nav 配置的 name 用 i18n 来处理，配置文件需要把 name 去掉
```
rule :admin do
  nav :courses, :url => '/admin/courses' do
    controller :'admin/courses'
    nav :import, :url => '/admin/courses/import' do
      controller 'admin/courses', :only => [:import]
    end
  end
end
```

然后需要在 i18n 配置中增加如下配置
```
simple-navbar:
  admin:
    courses: 课程管理
    import: 课程导入
```

需要注意的是，I18n文件针对嵌套的nav，并不分层。
全部都写在一层上。也就是说，实际编写配置时，同一个 rule 下,建议开发者在每个nav上用不一样的标识。
