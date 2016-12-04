def log_n_system(*args)
  puts("\n", *args)
  system(*args)
end

task :test do
  log_n_system 'mkdir -p tmp'
  log_n_system "rails new tmp/test_app --skip-bundle -f -m template.rb #{ENV['NEW_ARGS']}"
  log_n_system 'rubocop --only LineLength tmp/test_app'
end

task :clean do
  log_n_system 'rm -rf tmp/test_app'
end

task default: [:test, :clean]
