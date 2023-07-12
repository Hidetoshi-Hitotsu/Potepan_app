require 'rails_helper'

RSpec.describe "Potepan::Products", type: :system do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    visit potepan_product_path(product.id)
  end

  it "一覧ページへ戻るからその商品のカテゴリーページへ遷移すること" do
    click_link "一覧ページへ戻る"
    expect(page).to have_current_path(potepan_category_path(product.taxons.first.id))
  end

  it "商品の内容が表示されている" do
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price.to_s
    expect(page).to have_content product.description
  end

  it "page_headerに「SHOP」が表示されない" do
    within('.pageHeader') do
      expect(page).to_not have_content "SHOP"
    end
  end
end
