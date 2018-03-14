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

require_relative '../../../lib/options/sr_common_option_parser'
require_relative '../../../lib/defaults'

# SRCommonOptionParser unit tests class
class UnitTestsSRCommonOptionParser < Minitest::Test

  def test_sr_common_option_parser_default_broker_value
    sr_common_options_default_broker = Options::SRCommonOptionParser.new()
    sr_common_options_default_broker.parse([])
    assert_equal(
      Defaults::DEFAULT_BROKER,
      sr_common_options_default_broker.options.broker
    )
  end # test_sr_common_option_parser_default_broker_value

  def test_sr_common_option_parser_user_broker_value_short
    sr_common_options_user_broker_short = Options::SRCommonOptionParser.new()
    sr_common_options_user_broker_short.parse(["-b", "127.0.0.2:5672"])
    assert_equal(
      "127.0.0.2:5672",
      sr_common_options_user_broker_short.options.broker
    )
  end # test_sr_common_option_parser_user_broker_value_short

  def test_sr_common_option_parser_user_broker_value_long
    sr_common_options_user_broker_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_broker_long.parse(["--broker", "127.0.0.3:5672"])
    assert_equal(
      "127.0.0.3:5672",
      sr_common_options_user_broker_long.options.broker
    )
  end # test_sr_common_option_parser_user_broker_value_long

  def test_sr_common_option_parser_default_exit_timer_value
    default_sr_common_options_exit_timer = Options::SRCommonOptionParser.new()
    default_sr_common_options_exit_timer.parse([])
    assert_nil(
      default_sr_common_options_exit_timer.options.exit_timer
    )
  end # test_sr_common_option_parser_default_exit_timer_value

  def test_sr_common_option_parser_user_timeout_value_short_int
    user_sr_common_options_timeout_short_int = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_short_int.parse(["-t", "7"])
    assert_equal(
      7,
      user_sr_common_options_timeout_short_int.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_short_int

  def test_sr_common_option_parser_user_timeout_value_long_int
    user_sr_common_options_timeout_long_int = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_long_int.parse(["--timeout", "11"])
    assert_equal(
      11,
      user_sr_common_options_timeout_long_int.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_long_int

  def test_sr_common_option_parser_user_timeout_value_short_float
    user_sr_common_options_timeout_short_float = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_short_float.parse(["-t", "0.7"])
    assert_equal(
      0.7,
      user_sr_common_options_timeout_short_float.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_short_float

  def test_sr_common_option_parser_user_timeout_value_long_float
    user_sr_common_options_timeout_long_float = \
      Options::SRCommonOptionParser.new()
    user_sr_common_options_timeout_long_float.parse(["--timeout", "1.1"])
    assert_equal(
      1.1,
      user_sr_common_options_timeout_long_float.options.exit_timer.timeout
    )
  end # test_sr_common_option_parser_user_timeout_value_long_float

  def test_sr_common_option_parser_user_timeout_value_short_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["-t", "raise"])
    end
  end # test_sr_common_option_parser_user_timeout_value_short_raise

  def test_sr_common_option_parser_user_timeout_value_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--timeout", "raise"])
    end
  end # test_sr_common_option_parser_user_timeout_value_long_raise

  def test_sr_common_option_parser_user_timeout_value_short_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["-t", wrong_value])
    end
    assert_equal(
      "invalid argument: -t #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_timeout_value_short_raise_message

  def test_sr_common_option_parser_user_timeout_value_long_raise_message
    wrong_value = "raise"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--timeout", wrong_value])
    end
    assert_equal(
      "invalid argument: --timeout #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_timeout_value_long_raise_message

  def test_sr_common_option_parser_default_sasl_mechs_value
    default_sr_common_options_sasl_mechs = Options::SRCommonOptionParser.new()
    default_sr_common_options_sasl_mechs.parse([])
    assert_equal(
      Defaults::DEFAULT_SASL_MECHS,
      default_sr_common_options_sasl_mechs.options.sasl_mechs
    )
  end # test_sr_common_option_parser_default_sasl_mechs_value

  def test_sr_common_option_parser_user_sasl_mechs_value_long
    user_sr_common_options_sasl_mechs_long = Options::SRCommonOptionParser.new()
    user_sr_common_options_sasl_mechs_long.parse(
      ["--conn-allowed-mechs", "SASL"]
    )
    assert_equal(
      "SASL",
      user_sr_common_options_sasl_mechs_long.options.sasl_mechs
    )
  end # test_sr_common_option_parser_user_sasl_mechs_value_long

  def test_sr_common_option_parser_default_log_msgs_value
    sr_common_options_default_log_msgs = Options::SRCommonOptionParser.new()
    sr_common_options_default_log_msgs.parse([])
    assert_equal(
      Defaults::DEFAULT_LOG_MSGS,
      sr_common_options_default_log_msgs.options.log_msgs
    )
  end # test_sr_common_option_parser_default_log_msgs_value

  def test_sr_common_option_parser_user_log_msgs_value_long
    sr_common_options_user_log_msgs_long = Options::SRCommonOptionParser.new()
    sr_common_options_user_log_msgs_long.parse(["--log-msgs", "dict"])
    assert_equal(
      "dict",
      sr_common_options_user_log_msgs_long.options.log_msgs
    )
  end # test_sr_common_option_parser_user_log_msgs_value_long

  def test_sr_common_option_parser_user_log_msgs_value_long_interop
    sr_common_options_user_log_msgs_long_interop = \
      Options::SRCommonOptionParser.new()
    sr_common_options_user_log_msgs_long_interop.parse(["--log-msgs", "dict"])
    assert_equal(
      "dict",
      sr_common_options_user_log_msgs_long_interop.options.log_msgs
    )
  end # test_sr_common_option_parser_user_log_msgs_value_long

  def test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise
    assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--log-msgs", "hello"])
    end
  end # test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise

  def test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise_msg
    wrong_value = "hello"
    exception = assert_raises OptionParser::InvalidArgument do
      Options::SRCommonOptionParser.new().parse(["--log-msgs", wrong_value])
    end
    assert_equal(
      "invalid argument: --log-msgs #{wrong_value}",
      exception.message
    )
  end # test_sr_common_option_parser_user_log_msgs_value_wrong_long_raise_msg

end # class UnitTestsSRCommonOptionParser

# eof
