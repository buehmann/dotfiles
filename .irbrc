require 'irb/completion'
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000

begin
  require 'awesome_print'
  AwesomePrint.irb!
rescue LoadError
end
