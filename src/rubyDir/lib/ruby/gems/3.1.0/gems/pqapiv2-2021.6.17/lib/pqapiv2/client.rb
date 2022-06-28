# pqapiv2
#
# This file was automatically generated by APIMATIC v2.0
# ( https://apimatic.io ).

module Pqapiv2
  #  pqapiv2 client class.
  class Client
    attr_reader :config

    # Access to payments controller.
    # @return [PaymentsController] Returns the controller instance.
    def payments
      @payments ||= PaymentsController.new config
    end

    # Access to transfers controller.
    # @return [TransfersController] Returns the controller instance.
    def transfers
      @transfers ||= TransfersController.new config
    end

    # Access to spend_back controller.
    # @return [SpendBackController] Returns the controller instance.
    def spend_back
      @spend_back ||= SpendBackController.new config
    end

    # Access to prepaid_cards controller.
    # @return [PrepaidCardsController] Returns the controller instance.
    def prepaid_cards
      @prepaid_cards ||= PrepaidCardsController.new config
    end

    # Access to paper_checks controller.
    # @return [PaperChecksController] Returns the controller instance.
    def paper_checks
      @paper_checks ||= PaperChecksController.new config
    end

    # Access to bank_accounts controller.
    # @return [BankAccountsController] Returns the controller instance.
    def bank_accounts
      @bank_accounts ||= BankAccountsController.new config
    end

    # Access to balances controller.
    # @return [BalancesController] Returns the controller instance.
    def balances
      @balances ||= BalancesController.new config
    end

    # Access to receipts controller.
    # @return [ReceiptsController] Returns the controller instance.
    def receipts
      @receipts ||= ReceiptsController.new config
    end

    # Access to users controller.
    # @return [UsersController] Returns the controller instance.
    def users
      @users ||= UsersController.new config
    end

    # Access to documents controller.
    # @return [DocumentsController] Returns the controller instance.
    def documents
      @documents ||= DocumentsController.new config
    end

    # Access to webhooks controller.
    # @return [WebhooksController] Returns the controller instance.
    def webhooks
      @webhooks ||= WebhooksController.new config
    end

    # Access to program controller.
    # @return [ProgramController] Returns the controller instance.
    def program
      @program ||= ProgramController.new config
    end

    def initialize(connection: nil, timeout: 60, max_retries: 0,
                   retry_interval: 1, backoff_factor: 2,
                   retry_statuses: [408, 413, 429, 500, 502, 503, 504, 521, 522, 524, 408, 413, 429, 500, 502, 503, 504, 521, 522, 524],
                   retry_methods: %i[get put get put],
                   environment: Environment::PRODUCTION, config: nil)
      @config = if config.nil?
                  Configuration.new(connection: connection, timeout: timeout,
                                    max_retries: max_retries,
                                    retry_interval: retry_interval,
                                    backoff_factor: backoff_factor,
                                    retry_statuses: retry_statuses,
                                    retry_methods: retry_methods,
                                    environment: environment)
                else
                  config
                end
    end
  end
end
