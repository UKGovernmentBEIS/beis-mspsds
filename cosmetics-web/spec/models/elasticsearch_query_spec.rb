require "rails_helper"

RSpec.describe ElasticsearchQuery, type: :model do
  shared_examples_for "correct query" do
    specify do
      expect(query).to eq expected_es_query
    end
  end

  let(:query) { ElasticsearchQuery.new(q, category).build_query }

  context "search term is provided and category filter is empty" do
    it_behaves_like "correct query" do
      let(:q) { "Foo bar" }
      let(:category) { nil }

      let(:expected_es_query) {
        { query: { bool: { filter: nil, must: { multi_match: { fuzziness: "AUTO", query: "Foo bar" } } } } }
      }
    end
  end

  context "search term is provided and category filter is not empty" do
    it_behaves_like "correct query" do
      let(:q) { "Foo bar" }
      let(:category) { "Bar baz" }

      let(:expected_es_query) {
        {:query=>{:bool=>{:filter=>[{:nested=>{:path=>"components", :query=>{:bool=>{:should=>[{:term=>{:"components.display_root_category"=>"Bar baz"}}]}}}}], :must=>{:multi_match=>{:fuzziness=>"AUTO", :query=>"Foo bar"}}}}}
      }
    end
  end

  context "no search term is provided and category filter is empty" do
    it_behaves_like "correct query" do
      let(:q) { nil }
      let(:category) { nil }

      let(:expected_es_query) {
        {:query=>{:bool=>{:filter=>nil, :must=>{:match_all=>{}}}}}
      }
    end
  end

  context "no search term is provided and category filter is not empty" do
    it_behaves_like "correct query" do
      let(:q) { nil }
      let(:category) { "Bar baz" }

      let(:expected_es_query) {
        {:query=>{:bool=>{:filter=>[{:nested=>{:path=>"components", :query=>{:bool=>{:should=>[{:term=>{:"components.display_root_category"=>"Bar baz"}}]}}}}], :must=>{:match_all=>{}}}}}
      }
    end
  end
end