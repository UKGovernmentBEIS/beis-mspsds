require "active_support/concern"

module ProductDuplicates
  extend ActiveSupport::Concern

  included do
    after_create :search_for_duplicates

    has_many :potential_product_duplicates, dependent: :destroy
    has_many :duplicate_products, through: :potential_product_duplicates
  end

  private

  def search_for_duplicates
    duplicates = Product.search(construct_search_query)
    duplicates.each do |result|
      potential_product_duplicates.create(duplicate_product_id: result.id, score: result._score)
    end
  end

  def construct_search_query
    {
      query: {
        bool: {
          should: priority_fields + other_fields
        }
      }
    }
  end

  def priority_fields
    construct_query_from_keys(%i[name gtin model], 2)
  end

  def other_fields
    construct_query_from_keys(%i[brand mpn batch_number], 1)
  end

  def construct_query_from_keys(keys, boost)
    keys.reject { |key| self[key].blank? }
        .collect do |key|
          query = {
            match: {}
          }
          query[:match][key] = {
            "query": self[key],
            "boost": boost
          }
          query
        end
  end
end
