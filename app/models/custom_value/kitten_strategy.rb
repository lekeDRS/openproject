class CustomValue::KittenStrategy < CustomValue::ARObjectStrategy
  private

  def ar_class
    Kitten
  end

  def ar_object(value)
    Kitten.find_by(id: value)
  end
end
