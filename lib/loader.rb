
paths = [
  'cli',
  'controller',
  'default',
  'destination',
  'destination_builder',
  'helper',
  'manifest',
  'manifest_builder',
  'manifest_task',
  'manifest_task_builder',
  'project',
  'project_builder',
  'project_exception',
  'project_exception_handler',
  'project_options',
  'project_options_builder',
  'publish',
  'render_concat',
  'render_html',
  'render_html_builder',
  'render_html_partial',
  'render_html_partial_builder',
  'render_inspector',
  'sync',
  'var',
  'viewer'
]


paths.map do |path|
  path = File.join(Muwu::GEM_HOME_LIB_MUWU, path, '*.rb')
  Dir[path].each do |file|
    require file
  end
end
