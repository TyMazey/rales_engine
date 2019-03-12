class Transaction < ApplicationRecord
  belongs_to :invoice

  enum status: ["failed", "success"]
end
