class PhotoBox < AWS::S3::S3Object
  set_current_bucket_to 'chantal-et-henri.photos' 
  def self.exists(name)
    val=false
    begin
      PhotoBox.find("uploads/#{name}")
      val=true
    rescue
      val=false
    end 
    val   
  end
end