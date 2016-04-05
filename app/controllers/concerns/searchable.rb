module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search)
      if search
        where('name ILIKE? ', "%#{search}%")
      else
        all
      end
    end
  end
end
