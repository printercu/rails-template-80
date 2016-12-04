module Patcher
  module_function

  def patch(file, patch)
    return unless File.exists?(file)
    original = File.read(file)
    result = original
    each_chunk(patch) do |from, to|
      result = result.sub(from, to)
    end
    File.write(file, result)
  end

  def each_chunk(patch)
    patch.split("\n\n").each do |chunk|
      chunk << "\n" unless chunk[-1] == "\n"
      parts = chunk.lines.group_by { |x| x[0] }
      parts.each { |k, x| parts[k] = x.map { |s| s[1..-1] }.join }
      yield(parts['-'], parts['+'])
    end
  end
end

# Just to check compatibility with all versions.
Patcher.patch 'no-existing', ''

Patcher.patch 'Gemfile', <<RUBY
-  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
+  # Call 'byebug' anywhere in the code to stop execution
+  # and get a debugger console

-  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
+  # Access an IRB console on exception pages or
+  # by using <%= console %> anywhere in the code.

-  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
+  # Spring speeds up development by keeping your application running
+  #in the background. Read more: https://github.com/rails/spring
RUBY

Patcher.patch 'Rakefile', <<RUBY
-# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
+# for example lib/tasks/capistrano.rake,
+# and they will automatically be available to Rake.
RUBY

Patcher.patch 'config/application.rb', <<RUBY
-    # Settings in config/environments/* take precedence over those specified here.
+    # Settings in config/environments/* take precedence
+    # over those specified here.
RUBY

Patcher.patch 'config/environments/development.rb', <<RUBY
-  # Settings specified here will take precedence over those in config/application.rb.
+  # Settings specified here will take precedence over those in
+  # config/application.rb.
RUBY

Patcher.patch 'config/environments/production.rb', <<'RUBY'
-  # Settings specified here will take precedence over those in config/application.rb.
+  # Settings specified here will take precedence over those in
+  # config/application.rb.

-  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb
+  # `config.assets.precompile` and `config.assets.version` have moved to
+  # config/initializers/assets.rb

-  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]
+  # config.action_cable.allowed_request_origins = [
+  #  'http://example.com',
+  #  %r{http://example.*},
+  # ]

-  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
+  # Force all access to the app over SSL, use Strict-Transport-Security,
+  # and use secure cookies.

-  # Use a real queuing backend for Active Job (and separate queues per environment)
+  # Use a real queuing backend for Active Job
+  # (and separate queues per environment)

-  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
+  # Set this to true and configure the email server for immediate delivery
+  # to raise delivery errors.

-  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')
+  # config.logger = ActiveSupport::TaggedLogging.new(
+  #   Syslog::Logger.new 'app-name'
+  # )
RUBY

Patcher.patch 'config/environments/test.rb', <<RUBY
-  # Settings specified here will take precedence over those in config/application.rb.
+  # Settings specified here will take precedence over those in
+  # config/application.rb.
RUBY

Patcher.patch 'config/initializers/assets.rb', <<RUBY
-# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
+# application.js, application.css, and all non-JS/CSS in app/assets folder
+# are already added.
RUBY

Patcher.patch 'config/initializers/backtrace_silencers.rb', <<RUBY
-# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
+# You can add backtrace silencers for libraries that you're using
+# but don't wish to see in your backtraces.

-# You can also remove all the silencers if you're trying to debug a problem that might stem from framework code.
+# You can also remove all the silencers if you're trying to debug a problem
+# that might stem from framework code.
RUBY

Patcher.patch 'config/initializers/new_framework_defaults.rb', <<RUBY
-Rails.application.config.action_controller.forgery_protection_origin_check = true
+Rails.application.config.action_controller.
+  forgery_protection_origin_check = true

-# Do not halt callback chains when a callback returns false. Previous versions had true.
+# Do not halt callback chains when a callback returns false.
+# Previous versions had true.

-# Configure SSL options to enable HSTS with subdomains. Previous versions had false.
+# Configure SSL options to enable HSTS with subdomains.
+# Previous versions had false.
RUBY

Patcher.patch 'config/initializers/session_store.rb', <<RUBY
-Rails.application.config.session_store :cookie_store, key: <%= "'_#{app_name}_session'" %>
+Rails.application.config.session_store :cookie_store,
+  key: <%= "'_#{app_name}_session'" %>
RUBY

Patcher.patch 'config/initializers/wrap_parameters.rb', <<RUBY
-# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
+# Enable parameter wrapping for JSON.
+# You can disable this by setting :format to an empty array.
RUBY

Patcher.patch 'config/puma.rb', <<RUBY
-# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
+# Specifies the `port` that Puma will listen on to receive requests,
+# default is 3000.
RUBY

Patcher.patch 'db/seeds.rb', <<RUBY
-# This file should contain all the record creation needed to seed the database with its default values.
-# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
+# This file should contain all the record creation needed to seed the database
+# with its default values. The data can then be loaded with the rails db:seed
+# command (or created alongside the database with db:setup).

-#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
+#   movies = Movie.create([{name: 'Star Wars'}, {name: 'Lord of the Rings'}])
RUBY

Patcher.patch 'test/test_helper.rb', <<RUBY
-  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
+  # Setup all fixtures in test/fixtures/*.yml for all tests
+  # in alphabetical order.
RUBY
