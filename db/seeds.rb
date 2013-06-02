# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Book.create(
  name: 'wj',
  title: 'ジャンプ',
  checked_url: 'http://www.omoshiro-news.net/memo/tsugino.html',
  linked_url: 'http://www.shonenjump.com/j/'
)

Book.create(
  name: 'wm',
  title: 'マガジン',
  checked_url: 'http://www.omoshiro-news.net/memo/tsugino.html',
  linked_url: 'http://kc.kodansha.co.jp/magazine/index.php/02065'
)

Book.create(
  name: 'ws',
  title: 'サンデー',
  checked_url: 'http://www.omoshiro-news.net/memo/tsugino.html',
  linked_url: 'http://websunday.net/'
)

Book.create(
  name: 'wc',
  title: 'チャンピオン',
  checked_url: 'http://www.omoshiro-news.net/memo/tsugino.html',
  linked_url: 'http://www.akitashoten.co.jp/w-champion'
)
