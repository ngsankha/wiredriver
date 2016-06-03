describe 'Wiredriver::Common::Bridge' do
  describe '#new' do
    before :each do
      @url = "https://abc:xyz@example.com/pqrs/1234"
    end

    it "creates a new remote HTTP bridge" do
      @bridge = Wiredriver::Common::Bridge.new @url
      expect(@bridge.class).to be(Wiredriver::Common::Bridge)
    end

    it "throws if no URL is passed" do
      expect { Wiredriver::Common::Bridge.new }.to raise_error(ArgumentError)
    end

    it "throws if malformed URL is passed" do
      @url = "random"
      expect { Wiredriver::Common::Bridge.new @url }.to raise_error(Wiredriver::Error::BridgeError)
    end

    context "parses the base URL params" do
      before :each do
        @bridge = Wiredriver::Common::Bridge.new @url
      end

      it "should understand the scheme" do
        expect(@bridge.scheme).to be(:https)
      end

      it "should get the host" do
        expect(@bridge.host).to eq("example.com")
      end

      it "should get the port" do
        expect(@bridge.port).to eq(443)
      end

      it "should get the basic auth details" do
        expect(@bridge.userinfo).to eq("abc:xyz")
      end

      it "should get the base path" do
        expect(@bridge.path).to eq("/pqrs/1234")
      end
    end
  end
end
