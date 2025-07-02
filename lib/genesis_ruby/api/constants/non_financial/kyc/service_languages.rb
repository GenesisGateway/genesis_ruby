# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # ServiceLanguages class contains the available languages for KYC Non-Financial API services
          class ServiceLanguages

            extend Mixins::Constants::Common

            AVAILABLE_LANGUAGES = {
              'Arabic'                       => 'a',
              'Cantonese, Chinese/Hong Kong' => 'zh-HK',
              'Catalan'                      => 'ca',
              'Croatian'                     => 'hr',
              'Czech'                        => 'cs',
              'Danish'                       => 'da',
              'Dutch'                        => 'nl',
              'English, Australian'          => 'en-AU',
              'English, UK'                  => 'en-GB',
              'English, US'                  => 'en-US',
              'Estonian'                     => 'et',
              'Filipino'                     => 'fil',
              'Finnish'                      => 'fi',
              'French'                       => 'fr',
              'French, Canadian'             => 'fr-CA',
              'German'                       => 'de',
              'Greek'                        => 'el',
              'Hebrew'                       => 'he',
              'Hindi'                        => 'hi',
              'Hungarian'                    => 'hu',
              'Icelandic'                    => 'is',
              'Indonesian'                   => 'id',
              'Italian'                      => 'it',
              'Japanese'                     => 'ja',
              'Korean'                       => 'ko',
              'Latvian'                      => 'lv',
              'Lingala'                      => 'ln',
              'Lithuanian'                   => 'lt',
              'Mandarin'                     => 'zh-CN',
              'Norwegian'                    => 'no',
              'Polish'                       => 'pl',
              'Portuguese, Brazilian'        => 'pt-BR',
              'Portuguese, European'         => 'pt',
              'Romanian'                     => 'ro',
              'Russian'                      => 'ru',
              'Slovakian'                    => 'sk',
              'Spanish, European'            => 'es',
              'Spanish, Latin American'      => 'es-419',
              'Swedish'                      => 'sv',
              'Thai'                         => 'th',
              'Turkish'                      => 'tr',
              'Ukrainian'                    => 'uk',
              'Vietnamese'                   => 'vi'
            }.freeze

            # Returns the available languages for KYC Non-Financial API services
            def self.all
              AVAILABLE_LANGUAGES.values.map { |language| language.to_s.downcase }
            end

          end
        end
      end
    end
  end
end
