module Wiredriver
  module Error
    class NoSuchDriverError < RuntimeError
    end

    class NoSuchElementError < RuntimeError
    end

    class NoSuchFrameError < RuntimeError
    end

    class UnknownCommandError < RuntimeError
    end

    class StaleElementReferenceError < RuntimeError
    end

    class ElementNotVisibleError < RuntimeError
    end

    class InvalidElementStateError < RuntimeError
    end

    class UnknownError < RuntimeError
    end

    class ElementIsNotSelectableError < RuntimeError
    end

    class JavaScriptError < RuntimeError
    end

    class XPathLookupError < RuntimeError
    end

    class TimeoutError < RuntimeError
    end

    class NoSuchWindowError < RuntimeError
    end

    class InvalidCookieDomainError < RuntimeError
    end

    class UnableToSetCookieError < RuntimeError
    end

    class UnexpectedAlertOpenError < RuntimeError
    end

    class NoAlertOpenError < RuntimeError
    end

    class ScriptTimeoutError < RuntimeError
    end

    class InvalidElementCoordinatesError < RuntimeError
    end

    class IMENotAvailableError < RuntimeError
    end

    class IMEEngineActivationFailedError < RuntimeError
    end

    class InvalidSelectorError < RuntimeError
    end

    class SessionNotCreatedExceptionError < RuntimeError
    end

    class MoveTargetOutOfBoundsError < RuntimeError
    end

    class UnknownStatusError < RuntimeError
    end
  end
end
