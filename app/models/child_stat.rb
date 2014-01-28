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
    # http://stackoverflow.com/questions/5544858/accessing-elements-of-nested-hashes-in-ruby
    stats =  Hash.new { |h, k| h[k] = Hash.new { |hh, kk| hh[kk] = {} } }
    case type
      when "daily"
        time_range = 1.days.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        stats =  filter_data(stats, parent_stat, "user")
        stats =  filter_data(stats, others_stat, "other")
        stats[:title] = "daily"
        stats
      when "weekly"
        time_range = 1.weeks.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        stats =  filter_data(stats, parent_stat, "user")
        stats =  filter_data(stats, others_stat, "other")
        stats[:title] = "weekly"
        stats
      when "monthly"
        time_range = 1.months.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        stats =  filter_data(stats, parent_stat, "user")
        stats =  filter_data(stats, others_stat, "other")
        stats[:title] = 'monthly'
        stats
      when "yearly"
        time_range = 1.years.ago..Time.now
        parent_stat = perform_query_parent(child_id,time_range,parent_id)
        others_stat = perform_query_other(child_id,time_range,parent_id)
        stats =  filter_data(stats, parent_stat, "user")
        stats =  filter_data(stats, others_stat, "other")
        stats[:title] = "yearly"
        stats
      else
        stats
      end
  end

  def self.filter_data_x(records)
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

  def self.filter_data(stat,records, user)
    count =  records.length
    stat[:bottles_full][user.to_sym] = 0
    stat[:bottles_half][user.to_sym] = 0
    stat[:vaccines][user.to_sym] = 0
    stat[:meals][user.to_sym] = 0
    stat[:diapers][user.to_sym] = 0
    created_at =
    records.each do |record|
      stat[:graph][record.created_at.to_s][:weight] =  record.weight if record.weight
      stat[:graph][record.created_at.to_s][:height] =  record.height if record.height
      stat[:vaccines][user.to_sym] += 1 if record.vaccine_id
      stat[:meals][user.to_sym]  += 1 if record.meals
      stat[:diapers][user.to_sym]  += 1 if record.diapers
      if record.bottle == 1
        stat[:bottles_full][user.to_sym] += 1
      else
        stat[:bottles_half][user.to_sym] += 1
      end
    end
    stat
  end

  #def self.stat_hash_the_way_they_need(parent, others)
  #    stats = {}
  #    stats[:bottles_full] = {:user => parent[:bottles_full], :other => others[:bottles_full] }
  #    stat[:bottles_half]  = {:user => parent[:bottles_full], :other => others[:bottles_full] }
  #end

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
  #----------------------------------------------=---------------------
  #   As per davinder implementation
  #-----------------------------------------------------------
  #when "weekly"
  #time_range = 1.weeks.ago..Time.now
  #parent_stat = perform_query_parent(child_id,time_range,parent_id)
  #others_stat = perform_query_other(child_id,time_range,parent_id)
  #parent_stat =  filter_data(parent_stat)
  #parent_stat[:title] = 'monthly'
  #parent_stat[:byuser] = 0
  #child_stat = filter_data(child_stat)
  #child_stat[:title] = 'monthly'
  #child_stat[:byuser] = 1
  #[ parent_stat, child_stat]
end
