require "spec_helper"

describe OmniAuth::Strategies::Ufc do
  let(:access_token) { stub('AccessToken', options: {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', parsed: parsed_response) }

  let(:enterprise_site)             { 'https://some.other.site.com/api/v3' }
  let(:enterprise_authorize_url)    { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)        { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise_token_header)     { 'header' }
  let(:enterprise_token_param_name) { 'enterprise_token' }
  let(:enterprise) do
    OmniAuth::Strategies::Ufc.new('UFC_KEY', 'UFC_SECRET',
      {
        client_options: {
          site: enterprise_site,
          authorize_url: enterprise_authorize_url,
          token_url: enterprise_token_url
        },
        access_token_options: {
          header_format: enterprise_token_header,
          param_name: enterprise_token_param_name
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::Ufc.new({})
  end

  before(:each) do
    subject.stub!(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://launchpad.ufcfit.com")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('/oauth/auth')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('/oauth/token')
    end

    describe "should be overrideable" do
      it "for site" do
        enterprise.options.client_options.site.should eq(enterprise_site)
      end

      it "for authorize url" do
        enterprise.options.client_options.authorize_url.should eq(enterprise_authorize_url)
      end

      it "for token url" do
        enterprise.options.client_options.token_url.should eq(enterprise_token_url)
      end
    end
  end

  context "access token options" do
    it { expect(subject.options.access_token_options.header_format).to eq('OAuth %s') }
    it { expect(subject.options.access_token_options.param_name).to eq('access_token') }

    describe "should be overrideable" do
      it { expect(enterprise.options.access_token_options.header_format).to eq(enterprise_token_header) }
      it { expect(enterprise.options.access_token_options.param_name).to eq(enterprise_token_param_name) }
    end
  end

  context "#raw_info" do
    it "should use relative paths" do
      access_token.should_receive(:get).with('/oauth/user').and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end
end
