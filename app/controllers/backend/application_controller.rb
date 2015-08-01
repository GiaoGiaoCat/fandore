class Backend::ApplicationController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'backend' }
end
