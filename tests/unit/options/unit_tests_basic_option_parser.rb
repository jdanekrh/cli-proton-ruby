#!/usr/bin/env ruby
#--
# Copyright 2017 Red Hat Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++

require 'minitest/autorun'

require_relative '../../../lib/options/basic_option_parser'
require_relative '../../../lib/defaults'

# BasicOptionParser unit tests class
class UnitTestsBasicOptionParser < Minitest::Test

  def test_basic_option_parser_default_broker_value
    default_basic_options_broker = Options::BasicOptionParser.new()
    default_basic_options_broker.parse([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
      default_basic_options_broker.options.broker
    )
  end # test_basic_option_parser_default_broker_value

  def test_basic_option_parser_user_broker_value_short
    user_basic_options_broker_short = Options::BasicOptionParser.new()
    user_basic_options_broker_short.parse(["-b", "127.0.0.2:5672"])
    assert_equal(
      "127.0.0.2:5672",
      user_basic_options_broker_short.options.broker
    )
  end # test_basic_option_parser_user_broker_value_short

  def test_basic_option_parser_user_broker_value_long
    user_basic_options_broker_long = Options::BasicOptionParser.new()
    user_basic_options_broker_long.parse(["--broker", "127.0.0.3:5672"])
    assert_equal(
      "127.0.0.3:5672",
      user_basic_options_broker_long.options.broker
    )
  end # test_basic_option_parser_user_broker_value_long

  def test_basic_option_parser_default_exit_timer_value
    default_basic_options_exit_timer = Options::BasicOptionParser.new()
    default_basic_options_exit_timer.parse([])
    assert_nil(
      default_basic_options_exit_timer.options.exit_timer
    )
  end # test_basic_option_parser_default_exit_timer_value

  def test_basic_option_parser_user_timeout_value_short_int
    user_basic_options_timeout_short_int = Options::BasicOptionParser.new()
    user_basic_options_timeout_short_int.parse(["-t", "7"])
    assert_equal(
      7,
      user_basic_options_timeout_short_int.options.exit_timer.timeout
    )
  end # test_basic_option_parser_user_timeout_value_short_int

  def test_basic_option_parser_user_timeout_value_long_int
    user_basic_options_timeout_long_int = Options::BasicOptionParser.new()
    user_basic_options_timeout_long_int.parse(["--timeout", "11"])
    assert_equal(
      11,
      user_basic_options_timeout_long_int.options.exit_timer.timeout
    )
  end # test_basic_option_parser_user_timeout_value_long_int

  def test_basic_option_parser_user_timeout_value_short_float
    user_basic_options_timeout_short_float = Options::BasicOptionParser.new()
    user_basic_options_timeout_short_float.parse(["-t", "0.7"])
    assert_equal(
      0.7,
      user_basic_options_timeout_short_float.options.exit_timer.timeout
    )
  end # test_basic_option_parser_user_timeout_value_short_float

  def test_basic_option_parser_user_timeout_value_long_float
    user_basic_options_timeout_long_float = Options::BasicOptionParser.new()
    user_basic_options_timeout_long_float.parse(["--timeout", "1.1"])
    assert_equal(
      1.1,
      user_basic_options_timeout_long_float.options.exit_timer.timeout
    )
  end # test_basic_option_parser_user_timeout_value_long_float

  def test_basic_option_parser_user_timeout_value_short_raise
    user_basic_options_timeout_short_raise = Options::BasicOptionParser.new()
    assert_raises OptionParser::InvalidArgument do
      user_basic_options_timeout_short_raise.parse(["-t", "raise"])
    end
  end # test_basic_option_parser_user_timeout_value_short_raise

  def test_basic_option_parser_user_timeout_value_long_raise
    user_basic_options_timeout_long_raise = Options::BasicOptionParser.new()
    assert_raises OptionParser::InvalidArgument do
      user_basic_options_timeout_long_raise.parse(["--timeout", "raise"])
    end
  end # test_basic_option_parser_user_timeout_value_long_raise

  def test_basic_option_parser_user_timeout_value_short_raise_message
    wrong_value = "raise"
    user_basic_options_timeout_short_raise_message = \
      Options::BasicOptionParser.new()
    exception = assert_raises OptionParser::InvalidArgument do
      user_basic_options_timeout_short_raise_message.parse(["-t", wrong_value])
    end
    assert_equal(
      "invalid argument: -t #{wrong_value}",
      exception.message
    )
  end # test_basic_option_parser_user_timeout_value_short_raise_message

  def test_basic_option_parser_user_timeout_value_long_raise_message
    wrong_value = "raise"
    user_basic_options_timeout_long_raise_message = \
      Options::BasicOptionParser.new()
    exception = assert_raises OptionParser::InvalidArgument do
      user_basic_options_timeout_long_raise_message.parse(
        ["--timeout", wrong_value]
      )
    end
    assert_equal(
      "invalid argument: --timeout #{wrong_value}",
      exception.message
    )
  end # test_basic_option_parser_user_timeout_value_long_raise_message

  def test_basic_option_parser_default_sasl_mechs_value
    default_basic_options_sasl_mechs = Options::BasicOptionParser.new()
    default_basic_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_basic_options_sasl_mechs.options.sasl_mechs
    )
  end # test_basic_option_parser_default_sasl_mechs_value

  def test_basic_option_parser_user_sasl_mechs_value_long
    user_basic_options_sasl_mechs_long = Options::BasicOptionParser.new()
    user_basic_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_basic_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_basic_option_parser_user_sasl_mechs_value_long

end # class UnitTestsBasicOptionParser

# eof
