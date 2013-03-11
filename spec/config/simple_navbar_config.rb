# -*- coding: utf-8 -*-
SimpleNavbar::Base.config do
  # example
  # 
  # controller :media_resources, :except => [:xxx]
  # controller :file_entities, :only => [:upload]
  # end
  rule :simple do
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

  rule :multi_level_example do
    nav :index, :name => '首页', :url => '/' do
      controller :index, :only => :index
    end

    nav :movies, :name => '电影', :url => '/movies' do
      controller :movies
    end

    nav :musics, :name => '音乐', :url => '/musics' do
      controller :musics
      controller :pop_musics
      controller :rock_musics
      controller :punk_musics 

      nav :pop_musics, :name => '流行音乐', :url => '/musics/pop' do
        controller :pop_musics
        controller :rock_musics
        controller :punk_musics 

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
      controller :'admin/index'
    end
  end

end
