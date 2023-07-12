require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :request do
  describe "GET /show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { create(:taxon) }
    let(:other_taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let(:other_product) { create(:product, taxons: [other_taxon]) }
    let(:image) { create(:image) }
    let(:other_image) { create(:image) }

    before do
      product.images << image
      other_product.images << other_image
      get potepan_category_path(taxon.id)
    end

    it "HTTPリクエストが正常に完了すること" do
      expect(response).to have_http_status(:success)
    end

    it "カテゴリーに紐づく商品だけが取得できていること" do
      expect(response.body).to include(product.name)
      expect(response.body).to_not include(other_product.name)
    end

    it "商品情報が取得できていること" do
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.display_price.to_s)
    end

    it "カテゴリー情報が取得できていること" do
      expect(response.body).to include(taxon.name)
      expect(response.body).to include(taxonomy.name)
    end
  end
end
