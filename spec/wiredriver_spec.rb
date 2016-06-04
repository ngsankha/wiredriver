include Wiredriver

describe "Wiredriver::Driver" do
  describe "#new" do
    it "sends /session request" do
      stub_request(:post, "http://localhost:4444/wd/hub/session").
        with(:body => "{\"desiredCapabilities\":{\"browserName\":\"firefox\"}}",
             :headers => {'Content-Type'=>'application/json'}).
        to_return(:status => 200,
          :body => "{\"status\": 0, \"sessionId\": \"a1b2c3\", \"value\": {\"browserName\": \"firefox\"}}",
          :headers => {})

      Driver.new("http://localhost:4444/wd/hub", { "browserName" => "firefox" })
    end
  end

  context "after session is created" do
    before :each do
      stub_request(:post, "http://localhost:4444/wd/hub/session").
        with(:body => "{\"desiredCapabilities\":{\"browserName\":\"firefox\"}}",
             :headers => {'Content-Type'=>'application/json'}).
        to_return(:status => 200,
          :body => "{\"status\": 0, \"sessionId\": \"a1b2c3\", \"value\": {\"browserName\": \"firefox\"}}",
          :headers => {})

      @driver = Driver.new("http://localhost:4444/wd/hub", { "browserName" => "firefox" })
    end

    it "sessionId of the session can be accessed" do
      expect(@driver.session_id).to eq("a1b2c3")
    end

    it "#open_url" do
      stub_request(:post, "http://localhost:4444/wd/hub/session/a1b2c3/url").
         with(:body => "{\"url\":\"http://google.com\"}",
              :headers => {'Content-Type'=>'application/json'}).
         to_return(:status => 200,
           :body => "{\"status\": 0, \"sessionId\": \"a1b2c3\", \"value\": {}}",
           :headers => {})

      @driver.open_url "http://google.com"
    end

    it "#quit" do
      stub_request(:delete, "http://localhost:4444/wd/hub/session/a1b2c3").
         with(:headers => {'Content-Type'=>'application/json'}).
         to_return(:status => 200, :body => "", :headers => {})

      @driver.quit
    end
  end
end
