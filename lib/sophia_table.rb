# using "include SophiaTable".

module SophiaTable

  def sophia_table_class_name(object)
   object.Class.name
  end
  private
   
  def position_scope
    # default scope is always true
    # won't affect SQL conditions or narrow scope
    "1=1"
  end
  def increment_items(first, last)
    items = self.class.where("position >= ? AND position <= ? AND #{position_scope}", first, last)
    items.each { |i| i.update_attribute(:position, i.position + 1) }
  end
  def decrement_items(first, last)
    items = self.class.where("position >= ? AND position <= ? AND #{position_scope}", first, last)
    items.each { |i| i.update_attribute(:position, i.position - 1) }
  end
end

