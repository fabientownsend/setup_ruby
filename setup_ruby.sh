echo "create the Gemfile"
echo "source \"https://rubygems.org\"

gem 'rake'
gem 'rspec', '~> 3.0'
gem 'coveralls', require: false" >  Gemfile

echo "Create the Rakefile"
echo "require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end

task :default => :spec" > Rakefile

echo "installation bundle"
gem install bundle

echo "install dependency"
bundle install --binstubs

echo "initialisation rspec"
bin/rspec --init

echo "creation travis file"
echo "language: ruby
rvm:
- 2.3.0
script:
- bundle exec rspec" > .travis.yml

echo "require 'coveralls'
Coveralls.wear!" > test.txt
cat spec/spec_helper.rb >> test.txt
cp test.txt spec/spec_helper.rb
rm test.txt

echo "create class exemple"
mkdir lib
echo "class Example
  def exist?
    true
  end
end" > lib/example.rb

echo "create test exemple"

echo "require 'spec_helper'
require 'example'
RSpec.describe Example do
  it \"should execute the test\" do
    ex = Example.new
    expect(ex.exist?).to be true
  end
end" > spec/example_spec.rb

echo "launch the test"
rspec
