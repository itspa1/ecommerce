json.extract! coupon, :id, :name, :amount, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
