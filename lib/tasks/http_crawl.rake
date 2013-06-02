# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'kconv'

namespace :http_crawl do
  desc "crawl books for book_histories data"
  task book_histories: :environment do
    puts "start task http_crawl book_histories data...  >> " + Time.now.to_s

    book = Book.first
    url = book.checked_url
    docs = Nokogiri::HTML(open(url).read.toutf8, nil, 'utf-8')

    books = Book.all
    books.each do |book|
      docs.search("//table/tr/td/font/b").each do |doc|
        if doc.text =~ /#{book.title}/
          str = doc.parent.parent.parent.parent.xpath(".//tr[1]/td[2]").text # =>ex. 2013.No.22・23合併号 2013.No.21号
          hits_arr = str.scan(/([0-9]+)\.No\.([0-9]+).([0-9]+)|([0-9]+)\.No\.([0-9]+)/)
          if hits_arr[0].size >= 1
            if hits_arr[0][0].present?
              # 合併号
              book_history = book.book_histories.build(year: hits_arr[0][0], no: "#{hits_arr[0][1]},#{hits_arr[0][2]}")
            else
              # 単号
              book_history = book.book_histories.build(year: hits_arr[0][3], no: hits_arr[0][4])
            end
            puts "create book_history book: #{book.name}, year: #{book_history.year}, no: #{book_history.no}"
            book_history.save
          else
            # no hit
          end
        end
      end
    end
    
    puts "end task http_crawl book_histories data...  >> " + Time.now.to_s
  end
end
