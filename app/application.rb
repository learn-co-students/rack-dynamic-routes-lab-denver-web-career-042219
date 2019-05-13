class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      array = @@items.map do |item|
        item.name
      end
      #binding.pry
      if array.include?(item_name)
        @@items.each do |item|
          resp.write "#{item.price}\n"
        end
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
