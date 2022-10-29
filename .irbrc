# frozen_string_literal: true
require "irb/ext/save-history"
require "irb/completion"

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:PROMPT][:COLORED] = {
  PROMPT_I: "\e[91m%N\e[31m(\e[91m%m\e[31m)\e[m:\e[93m%03n\e[m:\e[94m%i\e[95m>\e[m ",
  PROMPT_N: "\e[91m%N\e[31m(\e[91m%m\e[31m)\e[m:\e[93m%03n\e[m:\e[94m%i\e[95m>\e[m ",
  PROMPT_S: "\e[91m%N\e[31m(\e[91m%m\e[31m)\e[m:\e[93m%03n\e[m:\e[94m%i\e[95m%l\e[m ",
  PROMPT_C: "\e[91m%N\e[31m(\e[91m%m\e[31m)\e[m:\e[93m%03n\e[m:\e[94m%i\e[95m*\e[m ",
  RETURN: "=> %s\n",
}
IRB.conf[:PROMPT_MODE] = :COLORED
IRB.conf[:EVAL_HISTORY] = 100
IRB.conf[:USE_AUTOCOMPLETE] = false
# RubyVM.keep_script_lines = true

require "clipboard"

def clipboard
  Clipboard.paste.encode("UTF-8")
end

def copy(val = :NULL)
  val = IRB.conf[:__TMP__EHV__][-1] if val == :NULL
  txt = val.is_a?(String) ? val : val.inspect
  Clipboard.copy(txt)
end

puts <<~MESSAGE
       \033[91m Running on Ruby #{RUBY_VERSION}, #{RUBY_PLATFORM} \e[m
     MESSAGE
