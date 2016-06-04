include Wiredriver::Common::Util

describe "Wiredriver::Common::Util" do
  describe "#build_url" do
    it "adds prefix to the base URL" do
      expect(build_url("/session", {}, "/wd/hub")).to eq("/wd/hub/session")
    end

    it "constructs template URLs" do
      expect(build_url("/session/:sessionId/window/:windowHandle/maximize",
       { "sessionId" => "1234", :windowHandle => 1 })).to eq("/session/1234/window/1/maximize")
    end

    it "escapes the constructed URL" do
      expect(build_url("/search/:query/now", { :query => "abc 123" })).to eq("/search/abc%20123/now")
    end
  end
end
