require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon_root) { taxonomy.root }
  let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxon_root) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:other_taxon) { create(:taxon, taxonomy: taxonomy, parent: taxon_root, name: "other_taxon") }
  let(:other_product) { create(:product, taxons: [other_taxon]) }
  let(:image) { create(:image) }
  let(:other_image) { create(:image) }

  before do
    product.images << image
    other_product.images << other_image
    visit potepan_category_path(taxon.id)
  end

  it "ページタイトルが表示されている" do
    expect(page).to have_title "#{taxon.name} - #{Constants::BASE_TITLE}"
  end

  it "サイドバーにカテゴリが表示されている" do
    within('.side-nav') do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content "#{taxon.name} (#{taxon.all_products.count})"
    end
  end

  it "カテゴリーに基づいた商品が表示されている" do
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price.to_s
    expect(page).to_not have_content other_product.name
  end

  it "カテゴリーに基づいていない商品は表示されない" do
    expect(page).to_not have_content other_product.name
  end

  it "商品をクリックすると商品詳細ページへ遷移する" do
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it "カテゴリーをクリックすると対象カテゴリーのページへ遷移する" do
    within('.side-nav') do
      click_on other_taxon.name
      expect(current_path).to eq potepan_category_path(other_taxon.id)
    end
  end

  it "表示されている商品一覧の個数と商品数が一致する" do
    expect(page.all('.productBox').count).to eq taxon.all_products.count
  end

  it "page_headerに「SHOP」が表示される" do
    within('.pageHeader') do
      expect(page).to have_content "SHOP"
    end
  end
end
