module DiariesHelper
  def get_pictures(pictures)

    pictures.each_with_index do |pic,index|

      pictures_url <<  request.protocol + request.host_with_port + pic.image_url
    end
    pictures_url
  end
end
