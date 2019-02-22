require 'rails_helper'

RSpec.describe PatternsController, type: :controller do
  describe '#create' do
    let(:post_request) do
      post :create, params: {
        pattern: {
          name: 'Amy Jumpsuit',
          price: '£15.00',
        }
      }
    end

    it 'creates a new pattern' do
      expect { post_request }.to change(Pattern, :count).by(1)
    end

    it 'shows the flash message' do
      post_request

      expect(flash[:notice]).to eql('Scrape Completed')
    end

    it 'redirects to the edit page' do
      expect(post_request).to redirect_to(patterns_path)
    end

    context 'when there are invalid attributes' do
      let(:post_request) do
        post :create, params: {
          pattern: {
            name: '',
            price: '',
          }
        }
      end

      it 'does not create a new pattern' do
        expect {
          post_request
        }.to_not change { Pattern.count }
      end

      it 'shows the flash message' do
        post_request

        expect(flash[:alert]).to eql('Scrape not Completed')
      end
    end
  end
end
