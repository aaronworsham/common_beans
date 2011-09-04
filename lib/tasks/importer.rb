require File.join(File.dirname(__FILE__),"../../config/environment.rb")
require 'faster_csv'

def map!(columns, row)
  mapped = {}
  columns.each_with_index do |column, i|
    next unless column
    mapped[column.downcase.gsub(/\s+/, '_').to_sym] = row[i]
  end
  mapped
end

def import_from_csv(options)
  raise "missing CSV file: #{options[:filename]}" unless File.exists?(options[:filename])
  csv    = FasterCSV.read(options[:filename])
  header = csv.shift
  csv.each do |row|
    map = map!(header, row)
    map.merge!(options)
    puts "Processing: #{row.join(', ')}"
    yield(map)
  end
end

