# encoding: utf-8
require 'open-uri'
require 'nokogiri'
require 'kconv'
require 'cosmicrawler'

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

  desc "crawl bookmarks for timelines data"
  task timelines: :environment do
    puts "start task http_crawl timelines data...  >> " + Time.now.to_s

    bookmarks = Bookmark
    urls = bookmarks.pluck(:checked_url)
    wj_book_histories = Book.find('wj').book_histories.recent.includes(:book)
    wm_book_histories = Book.find('wm').book_histories.recent.includes(:book)
    ws_book_histories = Book.find('ws').book_histories.recent.includes(:book)
    wc_book_histories = Book.find('wc').book_histories.recent.includes(:book)

    # http parallel requests per 8
    Cosmicrawler.http_crawl(urls) {|request|
      get = request.get
      if get.response_header.status == 200
        str = get.response.toutf8
        wj_book_histories.each do |book_history|
          prepare_create_timeline(str, book_history, request)
        end
        wm_book_histories.each do |book_history|
          prepare_create_timeline(str, book_history, request)
        end
        ws_book_histories.each do |book_history|
          prepare_create_timeline(str, book_history, request)
        end
        wc_book_histories.each do |book_history|
          prepare_create_timeline(str, book_history, request)
        end
      end
    }

    puts "end task http_crawl timelines data...  >> " + Time.now.to_s
  end
  
  def prepare_create_timeline(str, bh, req)
    no_arr = bh.no.split(',')
    if no_arr.size == 1
      # 単号
      if str =~ /#{bh.book.title}/ &&
          str =~ /(\s|　).*no.?.?.?.?.?#{bh.no}.*(\s|　)|(\s|　).*no\..?.?.?.?.?#{bh.no}.*(\s|　)|(\s|　).*#{bh.no}.?.?.?.?.?号.*(\s|　)/
        create_timeline(bh, req, $&)
      end
    else
      # 合併号
      if str =~ /#{bh.book.title}/ &&
          (str =~ /(\s|　).*no.?.?.?.?.?#{no_arr[0]}.*(\s|　)|(\s|　).*no\..?.?.?.?.?#{no_arr[0]}.*(\s|　)|(\s|　).*#{no_arr[0]}.?.?.?.?.?号.*(\s|　)/ ||
           str =~ /(\s|　).*no.?.?.?.?.?#{no_arr[1]}.*(\s|　)|(\s|　).*no\..?.?.?.?.?#{no_arr[1]}.*(\s|　).*|(\s|　).*#{no_arr[1]}.?.?.?.?.?号.*(\s|　)/)
        create_timeline(bh, req, $&)
      end
    end
  end
  
  def create_timeline(bh, req, s)
    bookmark = Bookmark.where(["checked_url = ?", req.uri]).first
    timeline = bookmark.timelines.build(book_history_id: bh.id, hit_text: ActionController::Base.helpers.strip_tags("#{s}"))

    puts "create timeline book: #{bh.book.name}, year: #{bh.year}, no: #{bh.no}, bookmark: #{bookmark.name}"
    timeline.save
  end
end
