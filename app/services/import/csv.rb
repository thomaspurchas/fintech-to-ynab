require 'csv'

# @note The CSV must contain: amount, description and date (YYYY-MM-DD)
# @note the amount must be the full value (so $100 would be 100)

class Import::Csv

  FORMATS = {
    'default' => 'Import::Csv',
    'starling' => 'Import::Csv::StarlingBank',
    'mbna' => 'Import::Csv::MBNA',
  }

  def initialize(path, ynab_account_id)
    @path = path
    @ynab_account_id = ynab_account_id
    @import_id_creator = YNAB::ImportIdCreator.new
  end

  def import
    transactions_to_create = []

    ::CSV.foreach(@path, headers: true) do |transaction|
      transaction = transaction.to_h.symbolize_keys
      amount = (transaction[:amount].to_f * 1000).to_i
      date = Date.parse(transaction[:date])

      transactions_to_create << {
        id: @import_id_creator.import_id(amount, date),
        amount: amount,
        payee_name: transaction[:description],
        date: date
      }
    end

    YNAB::BulkTransactionCreator.new(transactions_to_create, account_id: @ynab_account_id).create
  end
end
