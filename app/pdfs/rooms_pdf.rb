class RoomsPdf < Prawn::Document
  def initialize(rooms)
    super() 
    @rooms = []
    rooms.each do |r|
      @rooms << r if r.guests.size > 0
    end
    title
    heading
    room_items
    footer
  end
  
  def title
    text "Rooming List Chantal et Henri", style: :bold , size: 30
    move_down 20
  end
  
  def heading
    text "Liste des chambres", style: :bold, size: 18
  end
  
  def room_items
    move_down 20
    table room_item_rows do
      row(0).font_style = :bold
      column(2..3).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def room_item_rows
    [["Numero", "Invites"]] + 
    @rooms.compact.map do |room|      
      [room.number, room.guests_list]
    end
  end
  
  def footer
    move_down 15
    text "Total chambres: #{Room.count}", size: 16, style: :bold
  end
end
