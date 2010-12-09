require 'rubygems'

module Gem
  def self.patching(name, *requirements, &block)
   target = Gem::Dependency.new(name, *requirements)
   loaded_gem = Gem.loaded_specs[name]
   if loaded_gem && target.requirement.satisfied_by?(loaded_gem.version)
     yield if block_given?
   else
     msg = ["Attempt to apply patch targeting version '#{requirements.join(', ')}' of '#{name}'"]
     msg << (loaded_gem ? "but active version is '#{loaded_gem.version}'" : "but '#{name}' is not active")
     raise msg.join(', ')
   end
  end
end