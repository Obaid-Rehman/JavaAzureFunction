# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

require_relative 'controller_test_base'

class ProgramControllerTests < ControllerTestBase
  # Called only once for the class before any test has executed
  def setup
    @response_catcher = HttpResponseCatcher.new
    @controller = ProgramController.new CONFIG, http_call_back: @response_catcher
  end

  # Retrieve a list of all programs that supports filtering, sorting, and pagination through existing mechanisms.
  def test_list_programs()

    # Perform the API call through the SDK function
    @controller.list_programs()

    # Test response code
    assert_equal(200, @response_catcher.response.status_code)
  end

  # Retrieve a single program configuration
  def test_retrieve_program()
    # Parameters for the API call
    prog_token = 'prog-4525ab9c-5b22-4e30-028a-45901a10aa0c'

    # Perform the API call through the SDK function
    @controller.retrieve_program(prog_token)

    # Test response code
    assert_equal(200, @response_catcher.response.status_code)
  end

  # Retrieve a single program agreement
  def test_retrieve_program_agreement()
    # Parameters for the API call
    prog_token = 'prog-4525ab9c-5b22-4e30-028a-45901a10aa0c'
    agmt_token = 'agmt-45901a10-5b22-4e30-028a-45901a10baa9'

    # Perform the API call through the SDK function
    @controller.retrieve_program_agreement(prog_token, agmt_token)

    # Test response code
    assert_equal(200, @response_catcher.response.status_code)
  end

end
