class ChildStat < ActiveRecord::Base
  attr_accessible :diapers, :meals, :height, :weight ,:bottle ,:vaccine_id , :parent_profile_id

  belongs_to :child_profile
  has_one :vaccine
  belongs_to :parent_profile

  def self.perform_query_parent(child_id,time_range,parent_id)
    where(:child_profile_id => child_id).where("parent_profile_id = ?", parent_id).where(:created_at => time_range).all
  end

  def self.perform_query_other(child_id,time_range,parent_id)
    where(:child_profile_id => child_id).where("parent_profile_id != ?", parent_id).where(:created_at => time_range).all
  end

  def self.get_child_stat(child_id, parent_id, type=nil)
    #  time_range = 1.weeks.ago..Time.now
    case type
      when "daily"
        time_range = 1.days.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        parent_stat =  filter_data(parent_stat)
        parent_stat[:title] = 'monthly'
        parent_stat[:byuser] = 0
        child_stat = filter_data(others_stat)
        child_stat[:title] = 'monthly'
        child_stat[:byuser] = 1
        [ parent_stat, child_stat]
      when "weekly"
        time_range = 1.weeks.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        parent_stat =  filter_data(parent_stat)
        parent_stat[:title] = 'monthly'
        parent_stat[:byuser] = 0
        child_stat = filter_data(child_stat)
        child_stat[:title] = 'monthly'
        child_stat[:byuser] = 1
        [ parent_stat, child_stat]
      when "monthly"
        time_range = 1.months.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        parent_stat =  filter_data(parent_stat)
        parent_stat[:title] = 'monthly'
        parent_stat[:byuser] = 0
        child_stat = filter_data(child_stat)
        child_stat[:title] = 'monthly'
        child_stat[:byuser] = 1
        [ parent_stat, child_stat]
      when "yearly"
        time_range = 1.years.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        parent_stat =  filter_data(parent_stat)
        parent_stat[:title] = 'monthly'
        parent_stat[:byuser] = 0
        child_stat = filter_data(child_stat)
        child_stat[:title] = 'monthly'
        child_stat[:byuser] = 1
        [ parent_stat, child_stat]
      else
        time_range = 1.days.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        parent_stat =  filter_data(parent_stat)
        parent_stat[:title] = 'monthly'
        parent_stat[:byuser] = 0
        child_stat = filter_data(others_stat)
        child_stat[:title] = 'monthly'
        child_stat[:byuser] = 1
        [ parent_stat, child_stat]
      end
  end

  def self.filter_data(records)
    stat = {}
    count =  records.length
    stat[:bottles_full] = 0
    stat[:bottles_half] = 0
    stat[:vaccines] = 0
    stat[:meals] = 0
    stat[:diapers] = 0
    sum_weight = 0
    sum_height = 0
    records.each do |record|
      p record.weight
      sum_weight += record.weight if record.weight
      sum_height += record.height if record.height
      stat[:vaccines] += 1 if record.vaccine_id
      stat[:meals]  += 1 if record.meals
      stat[:diapers]  += 1 if record.diapers
      if record.bottle == 1
        stat[:bottles_full] += 1
      else
        stat[:bottles_half] += 1
      end
    end
    stat[:height] = sum_weight/count
    stat[:weight] = sum_height/count
    stat
  end


  #------------------------------------
  #format hash to return
  #{
  #“status”: true,
  #“stats” = [
  #    {
  #“title”: <day, week, month, year number>
  #“byuser”: “0- me, 1 – others”
  #“diapers” : <total diapers consumed>,
  #“weight” : <avg. weight of baby>,
  #“height” : <avg. height of baby>,
  #“meals” : <avg. number of times food given to baby>,
  #“bottles_full”: <number of full bottles>,
  #“bottles_half”:<number of half bottles>,
  #“vaccanies” : <total vaccaines>
  #
end
