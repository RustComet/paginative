module Paginative
  module ModelExtension
    extend ActiveSupport::Concern

    included do
        def self.by_distance_from(latitude, longitude, distance=0, limit=25)
          return [] unless latitude.present? && longitude.present?
          distance_sql = send(:distance_sql, latitude.to_f, longitude.to_f, {:units => :km, select_bearing: false})

          self.where("#{distance_sql} > #{distance}").offset(0).limit(limit)
        end

        def self.with_name_from(name="", limit=25)
          self.order(name: :asc).where("lower(name) > ?", name.downcase).offset(0).limit(limit)
        end

        # def self.with_id_from(id=0, limit=25)
        #   self.order(id: :asc).where("id > ?", id).limit(limit)
        # end

        def self.with_field_from(field="", value="", limit=25)
          self.order("#{field} ASC").where("#{field} >= '#{value}'").limit(limit)
        end
      # RUBY
    end
  end
end