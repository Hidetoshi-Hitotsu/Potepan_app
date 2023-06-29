require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#page_title" do
    context "引数がnilである" do
      it "#{Constants::BASE_TITLE}が表示される" do
        expect(page_title(nil)).to eq(Constants::BASE_TITLE)
      end
    end

    context "引数がnilでない" do
      it "pagetitleと#{Constants::BASE_TITLE}が表示される" do
        expect(page_title('PageTitle')).to eq("PageTitle - #{Constants::BASE_TITLE}")
      end
    end

    context "引数が空文字である" do
      it "#{Constants::BASE_TITLE}が表示される" do
        expect(page_title('')).to eq(Constants::BASE_TITLE)
      end
    end
  end
end
