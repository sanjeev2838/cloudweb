module DiariesHelper
  def get_pictures(pictures)
    pictures_url= Hash.new{|k,v|}
    pictures.each_with_index do |pic,index|
      pictures_url["image#{index+1}"]=  request.protocol + request.host_with_port + pic.image_url
    end
    pictures_url
  end
end
