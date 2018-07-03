Gem::Specification.new do |s|
  s.name          = 'logstash-input-facebook'
  s.version       = '0.1.4'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'This input plugin get the data from a facebook account.'
  s.description   = 'Aniadir aqui una descripcion completa.'
  s.homepage      = 'https://github.com/felixramirezgarcia/logstash-input-facebook'
  s.authors       = ['Felix R G']
  s.email         = 'felixramirezgarcia@gmail.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", ">= 2.0"
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'stud', '>= 0.0.22'
  s.add_development_dependency 'logstash-devutils', '>= 0.0.16'
  s.add_runtime_dependency 'koala', '~> 2.4' 

end
