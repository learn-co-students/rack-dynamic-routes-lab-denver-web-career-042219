class Application

  @@items = [Item.new("Apple", 2.12),
            Item.new("Dildo", 80.75)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last #turn /items/Dildo into Dildo
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
