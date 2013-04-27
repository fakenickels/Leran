Gem::Specification.new do |s|
	s.platform = Gem::Platform::RUBY
	s.name = 'leran'

	s.summary = "It's organize time"
	s.description = 'A simple File Organizer in Ruby'
	
	s.authors = ['Gabriel Rubens']
	s.email = 'grsabreu@gmail.com'

	s.version = '0.0.1'
	s.date = '2013-04-24'
	s.executables << 'leran'
	
	s.files = ['lib/leran.rb', 'bin/leran']
	s.homepage = 'http://rubygems.org/gems/leran'
	s.require_paths = ['lib']	
end
