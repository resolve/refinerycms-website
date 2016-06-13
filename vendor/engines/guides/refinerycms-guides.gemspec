Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-guides'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Guides engine for Refinery CMS'
  s.date              = '2010-11-30'
  s.summary           = 'Guides engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
  s.authors           = ["David Jones", "Philip Arndt"]
end
