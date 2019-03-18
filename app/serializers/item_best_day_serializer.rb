class ItemBestDaySerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day do |object|
    object.best_day.to_date
  end
end
