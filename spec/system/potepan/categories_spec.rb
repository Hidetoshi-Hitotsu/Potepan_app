require 'rails_helper'

RSpec.describe "Potepan::Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon_root) { taxonomy.root }
  let(:other_taxon) { create(:taxon, taxonomy: taxonomy, parent: taxon_root) }
  let(:other_product) { create(:product, taxons: [other_taxon]) }
  let(:image) { create(:image) }
  let(:other_image) { create(:image) }

  before do
    product.images << image
    other_product.images << other_image
    visit potepan_category_path(taxon.id)
  end

  scenario "ページタイトルが正しく表示されている" do
    expect(page).to have_title "#{taxon.name} - #{Constants::BASE_TITLE}"
  end

  scenario "サイドバーにカテゴリが正しく表示されている" do
    within('.side-nav') do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.products.count
    end
  end

  scenario "カテゴリーに基づいた商品が適切に表示されている" do
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price.to_s
    expect(page).to_not have_content other_product.name
  end

  scenario "商品をクリックすると商品詳細ページへ遷移する" do
    click_link "#{product.name}"
    expect(current_path).to eq potepan_product_path(product.id)
  end

  scenario "カテゴリーをクリックすると対象カテゴリーのページへ遷移する" do
    within('.side-nav') do
      click_on other_taxon.name
      expect(current_path).to eq potepan_category_path(other_taxon.id)
    end
  end
end
