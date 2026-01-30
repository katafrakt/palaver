# frozen_string_literal: true

module Palaver
  class LocaleDetector
    LOCALE_COOKIE_NAME = "locale"
    COOKIE_MAX_AGE = 31_536_000 # 1 year

    def initialize(req, res)
      @req = req
      @res = res
    end

    def detect
      # 1. Check URL param first, save to cookie if present
      if (param_locale = @req.params[:lang])
        normalized = normalize_locale(param_locale)
        if normalized
          @res.cookies[LOCALE_COOKIE_NAME] = {value: normalized.to_s, max_age: COOKIE_MAX_AGE}
          return normalized
        end
      end

      # 2. Check cookie
      if (cookie_locale = @req.cookies[LOCALE_COOKIE_NAME])
        normalized = normalize_locale(cookie_locale)
        return normalized if normalized
      end

      # 3. Check Accept-Language header
      if (header_locale = parse_accept_language)
        normalized = normalize_locale(header_locale)
        return normalized if normalized
      end

      # 4. Default to configured default locale
      default_locale
    end

    private

    def available_locales
      @available_locales ||= Hanami.app.config.i18n.available_locales.map(&:to_sym)
    end

    def default_locale
      Hanami.app.config.i18n.default_locale
    end

    def normalize_locale(locale)
      return nil if locale.nil? || locale.empty?

      sym = locale.to_s.downcase.to_sym
      available_locales.include?(sym) ? sym : nil
    end

    def parse_accept_language
      header = @req.get_header("HTTP_ACCEPT_LANGUAGE")
      return nil if header.nil? || header.empty?

      # Parse Accept-Language header (e.g., "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7")
      header.split(",").each do |lang_entry|
        # Extract language code (remove quality value if present)
        lang = lang_entry.split(";").first.strip.downcase
        # Return just the language part (e.g., "pl" from "pl-pl")
        lang_code = lang.split("-").first
        return lang_code unless lang_code.empty?
      end

      nil
    end
  end
end
