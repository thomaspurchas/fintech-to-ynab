require 'rails_helper'

RSpec.describe StarlingController, type: :controller do
  describe '#receive' do
    subject { post :receive, body: body.to_json, format: :json }
    let(:body) { {} }

    context 'when a URL_SECRET is set, but none is passed' do
      before { allow(ENV).to receive(:[]).with('URL_SECRET').and_return('SECRET') }
      it { is_expected.to have_http_status(401) }
      it { is_expected.to have_json('error' => 'unauthorised') }
    end

    context 'when a URL_SECRET is set, but and is passed' do
      before { allow(ENV).to receive(:[]).with('URL_SECRET').and_return('SECRET') }
      subject { post :receive, body: body.to_json, format: :json, params: { secret: 'SECRET' } }
      it { is_expected.to have_http_status(200) }
      it { is_expected.to have_json('error' => 'unsupported_type') }
    end

    context 'when sending no body' do
      it { is_expected.to have_http_status(200) }
      it { is_expected.to have_json('error' => 'unsupported_type') }
    end

    context 'when sending an unsupported webhook type' do
      let(:body) { { type: :not_supported } }
      it { is_expected.to have_http_status(200) }
      it { is_expected.to have_json('error' => 'unsupported_type') }
    end
  end
end
