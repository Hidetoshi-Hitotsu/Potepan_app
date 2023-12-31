require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /potepan/products/:id" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get potepan_product_path(product.id)
    end

    it "httpリクエストが正常に完了すること" do
      expect(response).to have_http_status(:success)
    end

    it "商品名を取得できること" do
      expect(response.body).to include(product.name)
    end

    it "商品価格を取得できること" do
      expect(response.body).to include(product.display_price.to_s)
    end

    it "商品説明を取得できること" do
      expect(response.body).to include(product.description)
    end
  end
end
