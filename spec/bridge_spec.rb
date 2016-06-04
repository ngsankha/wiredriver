include Wiredriver::Common

describe 'Wiredriver::Common::Bridge' do
  describe '#new' do
    before :each do
      @url = "https://abc:xyz@example.com:2345/pqrs/1234"
    end

    it "creates a new remote HTTP bridge" do
      @bridge = Bridge.new @url
      expect(@bridge.class).to be(Bridge)
    end

    it "throws if no URL is passed" do
      expect { Bridge.new }.to raise_error(ArgumentError)
    end

    it "throws if malformed URL is passed" do
      @url = "random"
      expect { Bridge.new @url }.to raise_error(Wiredriver::Error::BridgeError)
    end

    context "parses the base URL params" do
      before :each do
        @bridge = Bridge.new @url
      end

      it "should understand the scheme" do
        expect(@bridge.scheme).to be(:https)
      end

      it "should get the host" do
        expect(@bridge.host).to eq("example.com")
      end

      it "should get the port" do
        expect(@bridge.port).to eq(2345)
      end

      it "should get the default port if unspecified" do
        @url = "https://abc:xyz@example.com/pqrs/1234"
        @bridge = Bridge.new @url
        expect(@bridge.port).to eq(443)
      end

      it "userinfo should be nil if none is specified" do
        @url = "https://example.com:2345/pqrs/1234"
        @bridge = Bridge.new @url
        expect(@bridge.userinfo).to be(nil)
      end

      it "should get the basic auth details" do
        expect(@bridge.userinfo).to eq("abc:xyz")
      end

      it "should get the base path" do
        expect(@bridge.path).to eq("/pqrs/1234")
      end
    end
  end

  describe "#request" do
    before :each do
      @bridge = Bridge.new "http://example.com"
    end

    context "sends a request" do
      it "uses the method and path that is passed with Content-Type application/json" do
        stub_request(:get, "http://example.com/abcd").
          with(:headers => {'Content-Type'=>'application/json'}).
          to_return(:status => 200, :body => "boom", :headers => {})

        status, body = @bridge.request :get, "/abcd"
        expect(status).to eq(200)
        expect(body).to eq("boom")
      end

      it "writes the request body when specified" do
        stub_request(:post, "http://example.com/data").
          with(:body => "some data",
               :headers => {'Content-Type'=>'application/json'}).
          to_return(:status => 200, :body => "success", :headers => {})

        status, body = @bridge.request :post, "/data", "some data"
        expect(status).to eq(200)
        expect(body).to eq("success")
      end

      it "uses basic auth when specified" do
        url = "http://test:abcd@example.com"
        @bridge = Bridge.new url
        stub_request(:post, "http://example.com/data").
          with(:body => "some data",
               :headers => {'Authorization'=>'Basic dGVzdDphYmNk', 'Content-Type'=>'application/json'}).
          to_return(:status => 200, :body => "authed", :headers => {})

        status, body = @bridge.request :post, "/data", "some data"
        expect(status).to eq(200)
        expect(body).to eq("authed")
      end
    end

    it "throws an error in case the request failed" do
      stub_request(:any, "example.com").to_timeout
      expect { @bridge.request :get, "/" }.to raise_error(Curl::Err::TimeoutError)
    end

    it "follows 30x redirects" do
      stub_request(:post, "http://example.com/redirect").
        with(:body => "some data",
             :headers => {'Content-Type'=>'application/json'}).
        to_return(:status => 301, :body => "", :headers => {'Location'=>'example.com/final'})
      stub_request(:post, "http://example.com/final").
        with(:body => "some data",
             :headers => {'Content-Type'=>'application/json'}).
        to_return(:status => 200, :body => "yay!", :headers => {})

      status, body = @bridge.request :post, "/redirect", "some data"
      expect(status).to eq(200)
      expect(body).to eq("yay!")
    end
  end
end
