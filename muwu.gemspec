Gem::Specification.new do |s|
  s.name        = 'muwu'
  s.version     = '3.0.0'
  s.date        = '2020-11-14'
  s.licenses    = ['GPL-3.0']
  s.summary     = 'Markup Writeup'
  s.description = 'Compile markup files (Markdown and YAML) into HTML.'
  s.authors     = ['Eli Harrison']
  s.homepage    = 'https://github.com/ehdocumentdesign/muwu'
  s.files       = Dir['bin/*'] + Dir['lib/**/*'] + Dir['test/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.5.1'
  s.add_runtime_dependency 'commonmarker', '~> 0.21'
  s.add_runtime_dependency 'haml', '~> 5.1'
  s.add_runtime_dependency 'iso-639', '~> 0.3'
  s.add_runtime_dependency 'motion-markdown-it', '~> 8.4'
  s.add_runtime_dependency 'motion-markdown-it-plugins', '~> 8.4'
  s.add_runtime_dependency 'sassc', '~> 2.4'
  s.executables << 'muwu'
end
