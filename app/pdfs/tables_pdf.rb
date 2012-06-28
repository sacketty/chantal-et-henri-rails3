class TablesPdf < Prawn::Document
  def initialize()
    super() 
    @tables = Table.all
    title
    heading
    table_items
    footer
  end
  
  def title
    text "Plan de table Mariage Chantal et Henri", style: :bold , size: 30
    move_down 20
  end
  
  def heading
    text "Tables", style: :bold, size: 18
  end
  
  def table_items
    move_down 20
    table table_item_rows do
      row(0).font_style = :bold
      column(2..3).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def table_item_rows
    arr = [["Table", "Invites"]]
    @tables.each do |tb|
      arr += guest_item_rows(tb)
    end
    arr 
  end
  
  def guest_item_rows(tb)
    [["#{tb.name}", "#{tb.guests.size}"]] + 
    tb.guests.compact.map do |guest|
      ["",guest.name]
    end
  end
  
  def footer
    move_down 15
    text "Total tables: #{Table.count}", size: 16, style: :bold
    text "Total couverts: #{Guest.find(:all, :conditions=>"table_id IS NOT NULL").count}", size: 16, style: :bold
  end
  
end
