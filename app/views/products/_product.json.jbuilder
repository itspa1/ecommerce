json.extract! product, :id, :category_id, :name, :description, :price, :availability, :stock, :created_at, :updated_at
json.url product_url(product, format: :json)
