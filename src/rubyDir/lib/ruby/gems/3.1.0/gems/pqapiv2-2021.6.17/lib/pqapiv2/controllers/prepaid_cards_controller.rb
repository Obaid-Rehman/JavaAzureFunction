# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  # PrepaidCardsController
  class PrepaidCardsController < BaseController
    def initialize(config, http_call_back: nil)
      super(config, http_call_back: http_call_back)
    end

    # Replace an existing Prepaid Card specifying the replacement reason and the
    # card package for the replacement card.
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [Object] body Optional parameter: Example:
    # @return [PrepaidCardResponse] response from the API call
    def replace_prepaid_card(user_token,
                             dest_token,
                             x_my_pay_quicker_version,
                             body: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version,
        'Content-Type' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.post(
        _query_url,
        headers: _headers,
        parameters: body.to_json
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardResponse.from_hash(decoded)
    end

    # Retrieve Prepaid Card details by destination token.
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @return [PrepaidCardResponse] response from the API call
    def retrieve_prepaid_card(user_token,
                              dest_token,
                              x_my_pay_quicker_version)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.get(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardResponse.from_hash(decoded)
    end

    # Partial Prepaid Card update typically used when modifying card status.
    # <i>*Does not require the entire object be passed in the request</i>
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [PrepaidCardStatus] body Optional parameter: Example:
    # @return [PrepaidCardResponse] response from the API call
    def update_prepaid_card_partial(user_token,
                                    dest_token,
                                    x_my_pay_quicker_version,
                                    body: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version,
        'Content-Type' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.patch(
        _query_url,
        headers: _headers,
        parameters: body.to_json
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardResponse.from_hash(decoded)
    end

    # Retrieve one part of a two-part token required to reveal or set a client
    # side PIN. <i>*Not all programs support a reveal or set PIN operation.</i>
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @return [PrepaidCardPinToken] response from the API call
    def generate_pin_operation_token(user_token,
                                     dest_token,
                                     x_my_pay_quicker_version)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}/pin'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.get(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardPinToken.from_hash(decoded)
    end

    # Allows the setting of a PIN if supported by program.
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [String] token Required parameter: Token used as part of a two-leg
    # card PIN reveal request sent directly from the client, generally involving
    # a second piece of data such as the CVV code on the back of a card.
    # @param [String] card_pin Required parameter: Prepaid card PIN for ATM and
    # Debit usage
    # @return [UsersPrepaidCardsPinResponse] response from the API call
    def set_pin_if_supported(user_token,
                             dest_token,
                             x_my_pay_quicker_version,
                             token,
                             card_pin)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}/pin'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        'token' => token,
        'cardPin' => card_pin
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.put(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      UsersPrepaidCardsPinResponse.from_hash(decoded)
    end

    # Reveals the PIN for a card where PIN reveal functionality is supported in
    # the program and hosted by PayQuicker.
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] dest_token Required parameter: Auto-generated unique
    # identifier representing a transfer destination, including prepaid cards,
    # bank accounts, paper checks, and other users, prefixed with <i>dest->.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [String] token Required parameter: Token used as part of a two-leg
    # card PIN reveal request sent directly from the client, generally involving
    # a second piece of data such as the CVV code on the back of a card.
    # @param [String] cvc2 Required parameter: Card Verification Value (CVV)
    # located on the back of your credit card or debit card is a 3-digit number
    # on VISA® and MasterCard® branded credit cards, and debit cards.
    # @param [Object] body Optional parameter: Example:
    # @return [PrepaidCardPin] response from the API call
    def reveal_pin_if_supported(user_token,
                                dest_token,
                                x_my_pay_quicker_version,
                                token,
                                cvc2,
                                body: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}/pin'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        'token' => token,
        'cvc2' => cvc2
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version,
        'Content-Type' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.post(
        _query_url,
        headers: _headers,
        parameters: body.to_json
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardPin.from_hash(decoded)
    end

    # Retrieve a list of all pre-paid cards by user token that supports
    # filtering, sorting, and pagination through existing mechanisms.
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [Integer] page Optional parameter: Page number of specific page to
    # return
    # @param [Integer] page_size Optional parameter: Number of items to be
    # displayed per page
    # @param [String] filter Optional parameter: Filter request results by
    # specific criteria.
    # @param [String] sort Optional parameter: Sort request results by specific
    # attribute.
    # @param [LanguageTypesEnum] language Optional parameter: Filter results by
    # language type.
    # @return [PrepaidCardCollectionResponse] response from the API call
    def list_prepaid_cards(user_token,
                           x_my_pay_quicker_version,
                           page: nil,
                           page_size: 20,
                           filter: nil,
                           sort: nil,
                           language: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true }
      )
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        'page' => page,
        'pageSize' => page_size,
        'filter' => filter,
        'sort' => sort,
        'language' => language
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.get(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardCollectionResponse.from_hash(decoded)
    end

    # Order a pre-paid card for the user by specifying a cardPackage. <i>*A
    # package defines the type of card, currency, artwork utilized, and often
    # the method of delivery.</i>
    # @param [String] user_token Required parameter: Auto-generated unique
    # identifier representing a user, prefixed with <i>user-</i>.
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [PrepaidCardBase] body Optional parameter: Example:
    # @return [PrepaidCardRequestResponse] response from the API call
    def order_prepaid_card(user_token,
                           x_my_pay_quicker_version,
                           body: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true }
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version,
        'Content-Type' => 'application/json'
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.post(
        _query_url,
        headers: _headers,
        parameters: body.to_json
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardRequestResponse.from_hash(decoded)
    end

    # Generate a token used to reveal prepaid card information in the form of
    # image data (base64) or JSON.
    # @param [String] user_token Required parameter: Example:
    # @param [String] dest_token Required parameter: Example:
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [FormatEnum] format Required parameter: Desired format for the
    # prepaid card data.
    # @param [SideEnum] side Optional parameter: Side to specify when retrieving
    # a prepaid card's image data. *Required if IMAGE format specified.
    # @return [PrepaidCardDataTokenResponse] response from the API call
    def generate_prepaid_card_data_token(user_token,
                                         dest_token,
                                         x_my_pay_quicker_version,
                                         format,
                                         side: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}/pci'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        'format' => format,
        'side' => side
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.get(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardDataTokenResponse.from_hash(decoded)
    end

    # Return prepaid card data in the form of image data, text, or both.
    # @param [String] user_token Required parameter: Example:
    # @param [String] dest_token Required parameter: Example:
    # @param [String] x_my_pay_quicker_version Required parameter: Date-based
    # API Version specified in the header <i>required</i> on all calls.
    # @param [FormatEnum] format Required parameter: Desired format for the
    # prepaid card data.
    # @param [String] token Required parameter: Token used as part of a two-leg
    # card PIN reveal request sent directly from the client, generally involving
    # a second piece of data such as the CVV code on the back of a card.
    # @param [SideEnum] side Optional parameter: Side to specify when retrieving
    # a prepaid card's image data. *Required if IMAGE format specified.
    # @return [PrepaidCardDataResponse] response from the API call
    def get_prepaid_card_data(user_token,
                              dest_token,
                              x_my_pay_quicker_version,
                              format,
                              token,
                              side: nil)
      # Prepare query url.
      _query_builder = config.get_base_uri
      _query_builder << '/users/{user-token}/prepaid-cards/{dest-token}/pci'
      _query_builder = APIHelper.append_url_with_template_parameters(
        _query_builder,
        'user-token' => { 'value' => user_token, 'encode' => true },
        'dest-token' => { 'value' => dest_token, 'encode' => true }
      )
      _query_builder = APIHelper.append_url_with_query_parameters(
        _query_builder,
        'format' => format,
        'token' => token,
        'side' => side
      )
      _query_url = APIHelper.clean_url _query_builder

      # Prepare headers.
      _headers = {
        'accept' => 'application/json',
        'X-MyPayQuicker-Version' => x_my_pay_quicker_version
      }

      # Prepare and execute HttpRequest.
      _request = config.http_client.post(
        _query_url,
        headers: _headers
      )
      _response = execute_request(_request)
      validate_response(_response)

      # Return appropriate response type.
      decoded = APIHelper.json_deserialize(_response.raw_body)
      PrepaidCardDataResponse.from_hash(decoded)
    end
  end
end
