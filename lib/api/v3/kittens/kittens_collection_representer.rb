require 'roar/decorator'
require 'roar/json'
require 'roar/json/collection'
require 'roar/json/hal'

module API
  module V3
    module Kittens
      class KittenCollectionRepresenter < ::API::Decorators::UnpaginatedCollection
        element_decorator ::API::V3::Kittens::KittenRepresenter
      end
    end
  end
end
