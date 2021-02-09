# @api public
module Pundit
  SUFFIX = "Policy"

  # Error that will be raised when authorization has failed
  class NotAuthorizedError < Error

  class << self
    def authorize(user, record, query, policy_class: nil)
      policy = policy_class ? policy_class.new(user, record) : policy!(user, record)

      raise NotAuthorizedError, query: query, record: record, policy: policy unless policy.public_send(query)

      record.is_a?(Array) ? record.last : record
    end
  end
end