Gem::Specification.new do |gem|
  gem.name    = 'gem-patching'
  gem.version = '0.0.3'
  gem.summary = 'Better management of patches targeting specific versions of a specific gems'
  gem.description = 'gem-patching provides a mechanism for marking code blocks as a patch targeting specific versions of a gem and be notified when that gem is updated, so that developers can assess whether the patch continues to be necessary'
  gem.files = Dir['lib/**/*']
  gem.authors = ['Ingo Weiss']
  gem.email = 'ingo@ingoweiss.com'
  gem.homepage = 'http://github.com/ingoweiss/gem-patching'
  gem.files = Dir['{lib}/**/*']
end