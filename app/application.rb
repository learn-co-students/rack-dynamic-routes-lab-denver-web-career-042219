
class Application
  @@items = [Item.new("apples", 5.5), Item.new("bananas", 1.7)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      #@@items.each do |item|
        #if item == item_name
        # resp.write Item.price
        if item = @@items.find{|i| i.name == item_name}
            resp.write item.price
          else
            resp.write "Item not found"
            resp.status = 400
          end
      else
      resp.write "Route not found"
      resp.status = 404
      end

    resp.finish
  end
end
