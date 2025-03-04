require 'pry'
require_relative "./bank_account"

class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending' && self.amount < sender.balance
      receiver.deposit(amount)
      sender.deposit(-amount)
      self.status = 'complete'
    else
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      receiver.deposit(-amount)
      sender.deposit(amount)
      self.status = 'reversed'
    end
  end

end
