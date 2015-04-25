Gem::Specification.new do |s|
  s.name = 'train-numerals'
  s.version = '0.1'
  s.date = '2015-04-25'
  s.summary = 'Simple console app to train your English numerals knowledge.'
  s.description = <<-EOD
    This app has 2 modes: voice and words. In voice mode you listen to a numeral, write it and
    the app checks it correctness. In words mode the app shows you a number and you should write it
    in words (like this: 52 -> fifty two). The app will show you where you made an error (if you did).
  EOD
  s.authors = ['Alexey Shein']
  s.email = 'alexey.shein.dev@gmail.com'
  s.files = ['lib/train-numerals.rb']
  s.homepage = 'https://github.com/conf/train-numerals'
  s.license = 'MIT'
end
