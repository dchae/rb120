# quantity method called on line 11 without a quantity setter method.
# Fix by adding attr_writer :quantity, prefixing `quantity` on line 11 with "self."
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end

  private

  attr_writer :quantity
end

a = InvoiceEntry.new("Banana", 2)
p a
a.update_quantity(4)
p a
