class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.preload(:products).find(params[:id])
    @taxonomies = Spree::Taxonomy.all.includes(:root)
  end
end
