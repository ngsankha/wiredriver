require 'json'
require 'wiredriver/error/webdriver_errors'

include Wiredriver::Error

module Wiredriver
  module Common
    module Parser
      def parse(data)
        result = JSON.parse data
        case result["status"]
        when 0
          return result
        when 6
          raise NoSuchDriverError.new "A session is either terminated or not started."
        when 7
          raise NoSuchElementError.new "An element could not be located on the page using the given search parameters."
        when 8
          raise NoSuchFrameError.new "A request to switch to a frame could not be satisfied because the frame could not be found."
        when 9
          raise UnknownCommandError.new "The requested resource could not be found, or a request was received using an HTTP method that is not supported by the mapped resource."
        when 10
          raise StaleElementReferenceError.new "An element command failed because the referenced element is no longer attached to the DOM."
        when 11
          raise ElementNotVisibleError.new "An element command could not be completed because the element is not visible on the page."
        when 12
          raise InvalidElementStateError.new "An element command could not be completed because the element is in an invalid state (e.g. attempting to click a disabled element)."
        when 13
          raise UnknownError.new "An unknown server-side error occurred while processing the command."
        when 15
          raise ElementIsNotSelectableError.new "An attempt was made to select an element that cannot be selected."
        when 17
          raise JavaScriptError.new "An error occurred while executing user supplied JavaScript."
        when 19
          raise XPathLookupError.new "An error occurred while searching for an element by XPath."
        when 21
          raise TimeoutError.new "An operation did not complete before its timeout expired."
        when 23
          raise NoSuchWindowError.new "A request to switch to a different window could not be satisfied because the window could not be found."
        when 24
          raise InvalidCookieDomainError.new "An illegal attempt was made to set a cookie under a different domain than the current page."
        when 25
          raise UnableToSetCookieError.new "A request to set a cookie's value could not be satisfied."
        when 26
          raise UnexpectedAlertOpenError.new "A modal dialog was open, blocking this operation"
        when 27
          raise NoAlertOpenError.new "An attempt was made to operate on a modal dialog when one was not open."
        when 28
          raise ScriptTimeoutError.new "A script did not complete before its timeout expired."
        when 29
          raise InvalidElementCoordinatesError.new "The coordinates provided to an interactions operation are invalid."
        when 30
          raise IMENotAvailableError.new "IME was not available."
        when 31
          raise IMEEngineActivationFailedError.new "An IME engine could not be started."
        when 32
          raise InvalidSelectorError.new "Argument was an invalid selector (e.g. XPath/CSS)."
        when 33
          raise SessionNotCreatedExceptionError.new "A new session could not be created."
        when 34
          raise MoveTargetOutOfBoundsError.new "Target provided for a move action is out of bounds."
        else
          raise UnknownStatusError.new "Unrecognized error status code recieved."
        end
      end
    end
  end
end
