#!/usr/bin/env ruby
require 'sinatra/base'
require 'json'

class BookTracker < Sinatra::Base
  enable :inline_templates

  def self.app_path = "/books"

  on_start do
    unless File.exist? 'book.json'
      f = File.new 'book.json', 'a'
      f.puts '[]'
      f.close
    end
  end

  get '/' do
    books_list = JSON.parse File.read('book.json')
    erb :index, locals: { books_list: }
  end

  get '/add' do
    erb :add
  end

  post '/form' do
    params => {title:, review:, rating:, link:}
    review = { title:, review:, rating:, link:}

    book_json = JSON.parse File.read('book.json')
    book_json.prepend(review)
    File.write('book.json', book_json.to_json)

    redirect to('/')
  end
end


__END__
@@ head
<head>
  <!-- <link rel="stylesheet" href="https://unpkg.com/98.css"/>  -->
  <title>bookboxd</title>
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.red.min.css"
  >
</head>

@@ index
<html>
  <%= erb :head %>
  <body>
    <main>
      <% books_list.each do |book| %>
      <article>
        <h1><%= book['title'] %></h1>
        <p>
          <%= book['review'] %>
        </p>
        <p>
          <%= book['rating'] %>
        </p>
      </article>
      <% end %>
    </main>
  </body>
</html>

@@ add
<html>
  <%= erb :head %>

  <body>
    <main>
      <form action="./form" method="POST">
        <input type="text" name="title"/>
        <input type="text" name="review"/>
        <input type="text" name="link"/>
        <input type="number" name="rating"/>
        <button type="submit">Submit</button>
      </form>
    </main>
  </body>
</html>
