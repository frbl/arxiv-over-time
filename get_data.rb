#!/usr/bin/env ruby
require 'httparty'
require 'nokogiri'
require 'byebug'
require 'json'

def cache(name, data)
  out_file = File.new("#{filename(name)}", "w")
  out_file.puts(data)
  out_file.close
end

def cached?(name)
  File.exists? filename(name)
end

def from_cache(name)
  File.read(filename(name))
end

def generate_hashed_url_name(url)
  Digest::SHA1.hexdigest(url)
end

def filename(name)
  "/tmp/#{name}.research"
end

def remove_from_cache(url)
  puts "Removing file from cache: #{filename(generate_hashed_url_name(url))}"
  File.delete(filename(generate_hashed_url_name(url)))
end

def cached_call(url, headers = {})
  name = generate_hashed_url_name(url)
  if !cached?(name)
    res = HTTParty.get(url, headers: headers).body
    cache name, res
  end
  from_cache(name)
end

def retrieve_categories(categories)
  key = 'THESEARETHERESULTSWEAREINTERESTEDIN'
  base_url = 'http://export.arxiv.org/api/query?search_query='

  (@from..@to).map do |year|
    (1..12).map do |month|
      padded_month = month < 10 ? "0#{month}" : month
      padded_month_next = month < 9 || month == 12 ? "0#{(month % 12 + 1)}" : (month % 12 + 1)
      year_next = month == 12 ? year + 1 : year
      puts "#{padded_month} #{padded_month_next}"
      date = "submittedDate:[#{year}#{padded_month}01000000+TO+#{year_next}#{padded_month_next}31000000]"
      if categories
        query_url = base_url + categories + '+AND+' + date
      else
        query_url = base_url +  date
      end
      res = cached_call(query_url)

      # Hack, for some reason we cant read this..
      res = res.gsub('opensearch:totalResults',key)
      page = Nokogiri::XML(res)
      number = page.css(key).text
      puts "#{year}: #{number}"
      number
    end
  end
end

@from = 2008
@to = 2017

hash = {}
ml_cats = "cat:#{%w(cs.AI cs.LG cs.CV cs.CL cs.NE stat.ML).join('+OR+')}"

all_cats = 'all:*'
hash[:ml_cats] = retrieve_categories(ml_cats)
hash[:all_cats] = retrieve_categories(nil)

result = (@from..@to).map.with_index do |year, yidx|
  (1..12).map.with_index do |month, midx|
    numerator = hash[:ml_cats][yidx][midx]
    denominator = hash[:all_cats][yidx][midx]
    "01/#{month}/#{year}, #{(numerator.to_f / denominator.to_f) * 100}, #{numerator}" if denominator != '0'
  end.compact
end

out_file = File.new("papers.csv", "w")
out_file.puts('Date, percentage, total')
out_file.puts(result)
out_file.close

