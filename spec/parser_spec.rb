include Wiredriver::Common::Parser
include Wiredriver::Error

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

    context "Exceptions" do
      it "throws NoSuchDriverError" do
        expect { parse('{"status": 6, "value": { "key": "some string" } }') }.to raise_error(NoSuchDriverError)
      end

      it "throws NoSuchElementError" do
        expect { parse('{"status": 7, "value": { "key": "some string" } }') }.to raise_error(NoSuchElementError)
      end

      it "throws NoSuchFrameError" do
        expect { parse('{"status": 8, "value": { "key": "some string" } }') }.to raise_error(NoSuchFrameError)
      end

      it "throws UnknownCommandError" do
        expect { parse('{"status": 9, "value": { "key": "some string" } }') }.to raise_error(UnknownCommandError)
      end

      it "throws StaleElementReferenceError" do
        expect { parse('{"status": 10, "value": { "key": "some string" } }') }.to raise_error(StaleElementReferenceError)
      end

      it "throws ElementNotVisibleError" do
        expect { parse('{"status": 11, "value": { "key": "some string" } }') }.to raise_error(ElementNotVisibleError)
      end

      it "throws InvalidElementStateError" do
        expect { parse('{"status": 12, "value": { "key": "some string" } }') }.to raise_error(InvalidElementStateError)
      end

      it "throws UnknownError" do
        expect { parse('{"status": 13, "value": { "key": "some string" } }') }.to raise_error(UnknownError)
      end

      it "throws ElementIsNotSelectableError" do
        expect { parse('{"status": 15, "value": { "key": "some string" } }') }.to raise_error(ElementIsNotSelectableError)
      end

      it "throws JavaScriptError" do
        expect { parse('{"status": 17, "value": { "key": "some string" } }') }.to raise_error(JavaScriptError)
      end

      it "throws XPathLookupError" do
        expect { parse('{"status": 19, "value": { "key": "some string" } }') }.to raise_error(XPathLookupError)
      end

      it "throws TimeoutError" do
        expect { parse('{"status": 21, "value": { "key": "some string" } }') }.to raise_error(TimeoutError)
      end

      it "throws NoSuchWindowError" do
        expect { parse('{"status": 23, "value": { "key": "some string" } }') }.to raise_error(NoSuchWindowError)
      end

      it "throws InvalidCookieDomainError" do
        expect { parse('{"status": 24, "value": { "key": "some string" } }') }.to raise_error(InvalidCookieDomainError)
      end

      it "throws UnableToSetCookieError" do
        expect { parse('{"status": 25, "value": { "key": "some string" } }') }.to raise_error(UnableToSetCookieError)
      end

      it "throws UnexpectedAlertOpenError" do
        expect { parse('{"status": 26, "value": { "key": "some string" } }') }.to raise_error(UnexpectedAlertOpenError)
      end

      it "throws NoAlertOpenError" do
        expect { parse('{"status": 27, "value": { "key": "some string" } }') }.to raise_error(NoAlertOpenError)
      end

      it "throws ScriptTimeoutError" do
        expect { parse('{"status": 28, "value": { "key": "some string" } }') }.to raise_error(ScriptTimeoutError)
      end

      it "throws InvalidElementCoordinatesError" do
        expect { parse('{"status": 29, "value": { "key": "some string" } }') }.to raise_error(InvalidElementCoordinatesError)
      end

      it "throws IMENotAvailableError" do
        expect { parse('{"status": 30, "value": { "key": "some string" } }') }.to raise_error(IMENotAvailableError)
      end

      it "throws IMEEngineActivationFailedError" do
        expect { parse('{"status": 31, "value": { "key": "some string" } }') }.to raise_error(IMEEngineActivationFailedError)
      end

      it "throws InvalidSelectorError" do
        expect { parse('{"status": 32, "value": { "key": "some string" } }') }.to raise_error(InvalidSelectorError)
      end

      it "throws SessionNotCreatedExceptionError" do
        expect { parse('{"status": 33, "value": { "key": "some string" } }') }.to raise_error(SessionNotCreatedExceptionError)
      end

      it "throws MoveTargetOutOfBoundsError" do
        expect { parse('{"status": 34, "value": { "key": "some string" } }') }.to raise_error(MoveTargetOutOfBoundsError)
      end

      it "throws UnknownStatusError" do
        expect { parse('{"status": 35, "value": { "key": "some string" } }') }.to raise_error(UnknownStatusError)
      end
    end
  end
end
