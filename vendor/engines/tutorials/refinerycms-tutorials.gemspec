Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-tutorials'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Tutorials engine for Refinery CMS'
  s.date              = '2010-11-22'
  s.summary           = 'Tutorials engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']
end
