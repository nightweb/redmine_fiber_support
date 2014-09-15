Redmine::Plugin.register :redmine_fiber_support do
  name 'Redmine Fiber Support plugin'
  author 'Maksim Koritskiy'
  description 'This is a plugin for Redmine for fully support Puma webserver and Sidekiq'
  version '0.0.1'
  url 'https://github.com/nightweb/redmine_fiber_support'
  author_url 'http://koritskiy.ru/max'
end

Rails.configuration.to_prepare do
  require 'fiber'
  require_dependency 'user'
  require 'redmine_fiber_support/patches/user_patch'
  unless User.included_modules.include? RedmineFiberSupport::Patches::UserPatch
    User.send(:include, RedmineFiberSupport::Patches::UserPatch)
  end
end
