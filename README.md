simple-navbar
=============

a simple navbar plugin

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
  rule :simple do
    group :default, :name => '导航' do

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
  end
```

in routes
```ruby
  get "/" => "index#index"
  resources :books
```

browser get "/"
generate view

```html
<div class='page-navbar'>
  <div class='group'>
    <div class='title'>
      导航
    </div>
    <div class='items'>
      <div class='item current index'>
        <a href='/' class='lv1'>
          首页
        </a>
      </div>
      <div class='item books'>
        <a href='/books' class='lv1'>
          书籍
        </a>
      </div>
      <div class='item movies'>
        <a href='/movies' class='lv1'>
          电影
        </a>
      </div>
      <div class='item musics'>
        <a href='/musics' class='lv1'>
          音乐
        </a>
      </div>
    </div>
  </div>
</div>
```


browser get "/books" or browser get "/books/new" ....

generate view

```html
<div class='page-navbar'>
  <div class='group'>
    <div class='title'>
      导航
    </div>
    <div class='items'>
      <div class='item index'>
        <a href='/' class='lv1'>
          首页
        </a>
      </div>
      <div class='item books current'>
        <a href='/books' class='lv1'>
          书籍
        </a>
      </div>
      <div class='item movies'>
        <a href='/movies' class='lv1'>
          电影
        </a>
      </div>
      <div class='item musics'>
        <a href='/musics' class='lv1'>
          音乐
        </a>
      </div>
    </div>
  </div>
</div>
```
