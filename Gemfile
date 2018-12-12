source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in jaguar.gemspec
gemspec

unless ENV['JAGUAR_USE_RUBYGEMS'] == "yes"
  gem "delirium", path: "../delirium"
end
