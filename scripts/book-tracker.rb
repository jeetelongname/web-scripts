#!/usr/bin/env ruby

require_relative "../lib/web/scripts/"
require "json"

class BookTracker < Scripts::Base
  register_script
  enable :inline_templates

  def self.app_path = "/books"

  on_start do
    unless File.exist? "book.json"
      f = File.new "book.json", "a"
      f.puts "[]"
      f.close
    end
  end

  get "/" do
    books_list = JSON.parse File.read("book.json")
    erb :index, locals: { books_list: }
  end

  get "/add" do
    erb :add
  end

  post "/form" do
    params => { title:, review:, rating:, link:, is_link: }
    review = { title:, review:, rating:, link:, is_link: }

    book_json = JSON.parse File.read("book.json")
    book_json.prepend(review)
    File.write("book.json", book_json.to_json)

    redirect to("/")
  end
end

__END__
@@ head
<head>
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
    <header class="container">
      <h1> Books I have read </h1>
      <a href="/books/add"> Add a review </a>
    </header>
    <main   class="container">
      <% books_list.each do |book| %>
      <article>
        <h1><%= book['title'] %></h1>
        <p>
          <%= book['review'] %>
        </p>
        <p>
          <%= book['rating'] %>
        </p>
        <p>
          <% if book['is_link'] %>
          <a href=<%= book['link'] %>><%= book['link'] %></a>
          <% else %>
          <%= book['link']  %>
          <% end %>
      </article>
      <% end %>
    </main>
  </body>
</html>

@@ add
<html>
  <%= erb :head %>
  <body>
    <main class="container">
      <form action="./form" method="POST">
        <fieldset>
          <label>
            Title
            <input required type="text" name="title"/>
          </label>
          <label>
            review
            <input type="text" name="review"/>
          </label>
          <label>
            link or source
            <input type="textarea" name="link"/>
            <label>
              Is it a link?
              <input type="checkbox" name="is_link"/>
            </label>
          </label>
          <label oninput="ratingValue.value = rating.valueAsNumber">
            rating
            <input required type="range" min="0" max="10" step="1"
                   name="rating" value="1"
                   oninput="document.querySelector('#out').innerHTML= this.value;"
            />
            <p id="out">1</p>
          </label>
        </fieldset>
        <input type="submit" name="submit" value="Save review" />
      </form>
    </main>
  </body>
</html>
