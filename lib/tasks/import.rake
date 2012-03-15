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
    def import_etf_ticker(options)
      import_from_csv(
        :filename => options[:filename],
        :exchange => options[:exchange]
      ) do |map|
        if st = EtfTicker.find_by_symbol(map[:symbol])
           p 'Updating'
           st.update_attributes(
                   :exchange   => map[:exchange],
                   :name       => map[:name],
                   :symbol     => map[:symbol]
           )
        else
          p 'Creating'
          EtfTicker.create(
            :exchange   => map[:exchange],
            :name       => map[:name],
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
      import_etf_ticker(
        :exchange => Exchange.find_or_create_by_name('ETF'),
        :filename => 'db/data/ETF.csv'
      )
    end

    desc 'Import ETF Tickers'
    task :etf_tickers => :environment do
      import_etf_ticker(
        :exchange => Exchange.find_or_create_by_name('ETF'),
        :filename => 'db/data/ETF.csv'
      )
    end
    desc 'Import plans and strategies'
    task :plans_and_strategies => :environment do
      import_from_csv(
        :filename => 'db/data/plans.csv',
      ) do |map|
          p 'Creating'
          PortfolioPlan.create(
            :name       => map[:name]
          )
      end
      import_from_csv(
        :filename => 'db/data/strategies.csv',
      ) do |map|
          p 'Creating'
          PortfolioStrategy.create(
            :name       => map[:name]
          )
      end
    end
  end
end
