require "articles"

config.to_prepare do
  ApplicationController.helper(Beef::Articles)
end
 
ActionController::Base.send :include, Beef::Articles 