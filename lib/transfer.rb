class Transfer
  attr_accessor :status, :sender, :receiver, :amount

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
    @@all << self
  end

  def self.all
    @@all
  end

  def valid?
    @sender.status == "open" && @sender.balance > 0
    @receiver.status == "open" && @receiver.balance > 0
    @sender.valid?
    @receiver.valid?
  end

  def execute_transaction
    if self.status == "pending" && self.valid? && @sender.balance > self.amount
    @sender.balance = @sender.balance - self.amount
    @receiver.balance = @receiver.balance + self.amount
    self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @receiver.balance = @receiver.balance - self.amount   #@receiver.balance = -= self.amount
      @sender.balance = @sender.balance + self.amount       #@sender.balance = += self.amount
      self.status = "reversed"
    end

  end
end
