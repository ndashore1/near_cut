# frozen_string_literal: true

# CsvProcessor class
class CsvProcessor
  class << self
    def fetch_and_create_records(file)
      results = []
      csv = CSV.read(file, headers: true)
      verify_headers(csv.headers)
      csv.each do |row|
        next if row['name'].blank? || row['password'].blank?

        create_user(permit_record(row), results)
      end
      results
    end

    def validate_csv_file(file)
      if file.blank?
        'Please select a file.'
      elsif file.content_type != 'text/csv'
        'Please select file with CSV format'
      end
    end

    private

    def create_user(data, results)
      user = User.new(data)
      results << if user.save
                   "#{user.name.camelcase} was successfully saved."
                 else
                   user.errors.full_messages.join(', ')
                 end
    end

    def permit_record(row)
      row.to_hash.slice('name', 'password')
    end

    def verify_headers(headers)
      return if headers == %w[name password]

      raise 'Invalid Headers. Please refer Sample CSV.'
    end
  end
end
