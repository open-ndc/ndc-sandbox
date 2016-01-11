class DataList

  class ListItem
    attr_accessor :list_id, :id, :attributes

    def initialize(id = nil, attributes = nil)
      self.id = id if id
      self.attributes = attributes if attributes.present?
    end
  end

  def initialize
    @counter = 0
    @list = []
  end

  def << (item)
    if item.id && found_item = @list.find{|it| item.id == it.id}
      return found_item.list_id
    else
      new_list_id = item.list_id = (@counter += 1)
      @list << item
      return new_list_id
    end
  end

  def display
    @list.collect{|it| puts "list_id(#{it.list_id}) - Real id(#{it.id})"}
  end

end
