include Wiredriver::Common::Parser

describe "Wiredriver::Common::Parser" do
  describe "#parse" do
    it "throws an error if data is not JSON" do
      expect { parse("random data") }.to raise_error(JSON::ParserError)
    end

    it "returns a ruby object data is valid json and status is 0" do
      obj = parse('{"status": 0, "value": { "key": "some string" } }')
      expect(obj.class).to be(Hash)
      expect(obj["status"]).to eq(0)
      expect(obj["value"]["key"]).to eq("some string")
    end
  end
end
