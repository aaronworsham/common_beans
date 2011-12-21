namespace :cb do
  namespace :import do
    load 'lib/tasks/importer.rb'

    def import_stock_ticker(options)
      import_from_csv(
        :filename => options[:filename],
        :exchange => options[:exchange]
      ) do |map|
        if st = StockTicker.find_by_symbol(map[:symbol])
          p 'Updating'
           st.update_attributes(
                   :exchange   => map[:exchange],
                   :name       => map[:description],
                   :symbol     => map[:symbol]
           )
        else
          p 'Creating'
          StockTicker.create(
            :exchange   => map[:exchange],
            :name       => map[:description],
            :symbol     => map[:symbol]
          )
        end
      end
    end

    def import_fund_ticker(options)
      import_from_csv(
        :filename => options[:filename],
        :exchange => options[:exchange]
      ) do |map|
        if st = FundTicker.find_by_symbol(map[:symbol])
           p 'Updating'
           st.update_attributes(
                   :exchange   => map[:exchange],
                   :name       => map[:description],
                   :symbol     => map[:symbol]
           )
        else
          p 'Creating'
          FundTicker.create(

            :exchange   => map[:exchange],
            :name       => map[:description],
            :symbol     => map[:symbol]
          )
        end
      end
    end
    desc 'Import Tickers'
    task :tickers => :environment do
      import_stock_ticker(
        :exchange => Exchange.find_or_create_by_name('NYSE'),
        :filename => 'db/data/NYSE.csv'
      )
      import_stock_ticker(
        :exchange => Exchange.find_or_create_by_name('NASDAQ'),
        :filename => 'db/data/NASDAQ.csv'
      )
      import_fund_ticker(
        :exchange => Exchange.find_or_create_by_name('USMF'),
        :filename => 'db/data/USMF.csv'
      )
    end

    desc 'Import Index symbols'
    task :index_symbols => :environment do
      import_from_csv(
        :filename => 'db/data/INDEX.csv'
      ) do |map|
        Index.create(
          :name         => map[:name],
          :symbol       => map[:symbol],
          :yahoo_symbol => map[:yahoo_symbol]
        )
      end
    end
    desc 'Import Dow Index EOD'
    task :dow => :environment do
      import_from_csv(
        :filename => 'db/data/DJI.csv'
      ) do |map|
        DowIndexEod.create(
          :close        => map[:close],
          :net_change   => map[:net_change],
          :closed_on    => map[:date]
        )
      end
    end
  end
end
