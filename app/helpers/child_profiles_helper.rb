module ChildProfilesHelper
  def get_child_dairy_log(diary)
    pictures = Picture.find_all_by_diary_id(diary.id)
    log_str = diary.log
    milestones = diary.milestones
    unless diary.log.nil?
      (pictures).each_with_index do |item, index|
        if log_str.include?("@image#{index+1}@")
          log_str["@image#{index+1}@"] =  wicked_pdf_image_tag(item.image_url,:height => 30)
        end
      end
      milestones.each_with_index do |milestone,index|
        if log_str.include?("$milestone#{index+1}$")
          log_str["$milestone#{index+1}$"] =  wicked_pdf_image_tag(milestone.image_url,:height => 30)
        end
      end
    end
    log_str
  end
end
