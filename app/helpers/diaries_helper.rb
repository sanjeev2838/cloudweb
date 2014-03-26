module DiariesHelper
  def get_pictures(pictures)
    pictures_url= []
    pictures.each_with_index do |pic,index|
     pictures_url <<  request.protocol + request.host_with_port + pic.image_url
    end
    pictures_url
  end

  def get_milestones(diary)
    milestone_url = []
    @milestones = diary.milestones
    @milestones.each_with_index do |milestone,index|
      milestone_url << request.protocol + request.host_with_port + milestone.image_url
    end
    milestone_url
  end
end
