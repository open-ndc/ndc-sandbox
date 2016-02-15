require 'minitest/autorun'
require 'test/unit'

require 'net-http-spy'
Net::HTTP.http_logger_options = {trace: true, verbose: false}
