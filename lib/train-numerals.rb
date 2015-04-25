#!/usr/bin/env ruby
begin
  require 'humanize'
  require 'colorize'
  require 'wdiff'
rescue LoadError => e
  puts 'Make sure you have installed gems "humanize", "wdiff", and "colorize".'
  puts 'On OS X this will be sufficent:'
  puts '$ brew install wdiff'
  puts '$ gem install humanize colorize wdiff'
  puts e.message
  exit(1)
end

MAX_NUMBER = (ARGV.grep(/^\d+$/).first || 10_000).to_i
voice_mode = ARGV.grep(/^--voice$/).first

common_greeting = <<-EOD
Greetings! Let's test your English numerals knowledge!
EOD

voice_greeting = <<-EOD
I'll say you a number from 0 to #{MAX_NUMBER} and you should write
it back like this:
> (listen to a number)
< 92
> Correct!
EOD

words_greeting = <<-EOD
I'll write you a number from 0 to #{MAX_NUMBER} and you should write
it back in words like this:
> 92
< ninety two
> Correct!
EOD

common_ending = <<-EOD
Let's start! (You can always finish the program with simple Enter)
EOD

puts common_greeting
puts voice_mode ? voice_greeting : words_greeting
puts common_ending

def colored_word_diff(original, string)
  colored_inserts = 'green'.green.split('green')
  colored_deletes = 'red'.red.split('red')
  string.wdiff(original, inserts: colored_inserts, deletes: colored_deletes)
end

loop do
  number = rand(MAX_NUMBER)
  correct = voice_mode ? number.to_s : number.humanize.gsub(/\W+/, ' ')

  if voice_mode
    puts '> (listen to a number)'
    system("say -v Victoria '#{correct}'")
  else
    puts "> #{number}"
  end

  print '< '
  input = (STDIN.gets || '').chomp.strip
  if correct == input
    puts "> #{'Correct!'.green}"
  elsif input.empty?
    puts '> Bye bye!'
    exit(0)
  else
    puts "> #{'Incorrect!'.red} Right answer: #{correct.green}"
    puts "> Diff: #{colored_word_diff(correct, input)}" unless voice_mode
  end
end
