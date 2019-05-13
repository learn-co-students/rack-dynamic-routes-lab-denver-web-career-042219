class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_item = req.path.split("/items/").last
      found = find_item(search_item)

      if found.nil?                                              #how do I avoid the if statement?
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write found.price                                  #calls on found calls the find_item method which uses find.  returns that object, the .price gets us the price of the item found
      end

    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end

  def find_item(search_item)                                    #is there a way to just return price?
    @@items.find do |item|
      item.name == search_item
    end
  end

end
