Gem::Specification.new do |s|
  s.name        = 'yaml-lint'
  s.version     = '0.0.6'
  s.date        = '2015-06-16'
  s.summary     = 'Really simple YAML lint'
  s.description = 'Check if your YAML files can be loaded.'
  s.homepage    = 'https://github.com/Pryz/yaml-lint'
  s.authors     = ['Julien Fabre']
  s.email       = 'ju.pryz@gmail.com'
  s.files       = ['lib/yaml-lint.rb', 'bin/yaml-lint']
  s.executables << 'yaml-lint'
  s.license     = 'MIT'
end
