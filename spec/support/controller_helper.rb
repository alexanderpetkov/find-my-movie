module Support
  module ControllerHelper
    def get_xhr(route, params = {})
      get route, xhr: true, params: params
    end
  end
end
