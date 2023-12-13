Gem::Specification.new do |s|
  s.name        = 'muwu'
  s.version     = '3.2.0'
  s.date        = '2023-12-12'
  s.licenses    = ['GPL-3.0']
  s.summary     = 'Markup Writeup'
  s.description = 'Compile markup files (Markdown and YAML) into HTML.'
  s.authors     = ['Eli Harrison']
  s.homepage    = 'https://github.com/ehdocumentdesign/muwu'
  s.files       = Dir['bin/*'] + Dir['lib/**/*'] + Dir['test/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2'
  s.add_runtime_dependency 'commonmarker', '~> 0.23'
  s.add_runtime_dependency 'haml', '~> 6.3'
  s.add_runtime_dependency 'iso-639', '~> 0.3'
  s.add_runtime_dependency 'kramdown', '~> 2.4'
  s.add_runtime_dependency 'motion-markdown-it', '~> 13.0'
  s.add_runtime_dependency 'motion-markdown-it-plugins', '~> 8.4'
  s.add_runtime_dependency 'sassc', '~> 2.4'
  s.executables << 'muwu'
end
