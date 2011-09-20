namespace :cb do
  namespace :import do
    load 'lib/tasks/importer.rb'

    def import_exchange(options)
      import_from_csv(
        :filename => options[:filename],
        :exchange => options[:exchange]
      ) do |map|
        Ticker.create(
          :exchange   => map[:exchange],
          :name       => map[:description],
          :symbol     => map[:symbol]
        )
      end
    end
    desc 'Import Tickers'
    task :tickers => :environment do
      import_exchange(
        :exchange => Exchange.find_or_create_by_name('NYSE'),
        :filename => 'db/data/NYSE.csv'
      )
      import_exchange(
        :exchange => Exchange.find_or_create_by_name('NASDAQ'),
        :filename => 'db/data/NASDAQ.csv'
      )
    end
  end
end
