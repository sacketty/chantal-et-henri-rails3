class GuestsListPdf < Prawn::Document
  def initialize()
    super() 
    @guests = Guest.find(:all, conditions: "room_id > 0", order: "name ASC")
    title
    heading
    guest_items
    footer
  end
  
  def title
    text "Mariage Chantal et Henri", style: :bold , size: 30
    move_down 20
  end
  
  def heading
    text "Liste des invites (par chambre)", style: :bold, size: 18
  end
  
  def guest_items
    move_down 20
    table guest_item_rows do
      row(0).font_style = :bold
      column(2..3).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def guest_item_rows
    [["Nom", "Chambre"]] + 
    @guests.compact.map do |guest|
      number = guest.room ? guest.room.number : ""
      [guest.name, number]
    end
  end
  
  def footer
    move_down 15
    text "Total chambres: #{Room.count}", size: 16, style: :bold
  end
  
end
