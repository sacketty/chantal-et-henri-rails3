class GuestsPdf < Prawn::Document
  def initialize(guests)
    super() 
    @guests = guests
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
    text "Liste des invites", style: :bold, size: 18
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
    m = 
    d = Presence.count(conditions: ["diner = ?", true])
    [["Nom", "Mairie", "Diner", "Chambre"]] + 
    @guests.compact.map do |guest|
      [guest.name, guest.at_mairie? ? "x" : "", guest.at_diner? ? "x" : "", guest.room ? guest.room.name : ""]
    end
  end
  
  def footer
    move_down 15
    text "Total mairie: #{Presence.count(conditions: ["mairie = ?", true])}", size: 16, style: :bold
    text "Total diner: #{Presence.count(conditions: ["diner = ?", true])}", size: 16, style: :bold
    text "Total chambres: #{Room.count}", size: 16, style: :bold
  end
end
