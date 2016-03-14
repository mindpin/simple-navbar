simple-navbar
=============

rails 导航插件

[![Build Status](https://travis-ci.org/mindpin/simple-navbar.png?branch=master)](https://travis-ci.org/mindpin/simple-navbar)
[![Coverage Status](https://coveralls.io/repos/mindpin/simple-navbar/badge.png?branch=master)](https://coveralls.io/r/mindpin/simple-navbar)
[![Code Climate](https://codeclimate.com/github/mindpin/simple-navbar.png)](https://codeclimate.com/github/mindpin/simple-navbar)

## 安装

Gemfile:  
```bash
gem 'simple-navbar', :github => 'mindpin/simple-navbar',
                     :tag => "0.0.7"
```

## 配置

运行如下命令会生成 `config/simple_navbar_config.rb` 配置文件，根据需要修改该文件就可以了
```bash
rails g simple_navbar_config config
```

## 使用

### simple_navbar(rule_name)
可以用该方法生成导航  

```scss
@import "simple_navbar";
```

```haml
 # haml
 = simple_navbar(:simple)
```

### simple_breadcrumbs(rule_name, &block)
可以用该方法生成面包屑
```haml
# haml

= simple_breadcrumbs(:simple) do |b|
  - b.add "a","/a"
  - b.add "ab","/a/b"
```

### simple_navtabs(rule_name)
可以生成标签页导航
```haml
 # haml
 = simple_navtabs(:simple)
```

### quick_filter_bar
可以生成快速筛选条
```scss
@import "quick_filter_bar";
```

```haml
# haml
= quick_filter_bar do |builder|
  - builder.group :result, :text => "结果" do |group|
    - group.add "true",   :text => "正确"
    - group.add "false", :text => "错误"
  - builder.group :kind, :text => "类型" do |group|
    - group.add "single_choice",   :text => "单选"
    - group.add "mutli_choice", :text => "多选"
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
