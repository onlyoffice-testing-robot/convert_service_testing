task default: %w[run]

task :test do
  ruby "test/unittest.rb"
end