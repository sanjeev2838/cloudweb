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
    records.each do |record|
      stat[:graph][record.created_at.to_s][:weight] =  record.weight if record.weight
      stat[:graph][record.created_at.to_s][:height] =  record.height if record.height
      stat[:vaccines][user.to_sym] += 1 if record.vaccine_id
      stat[:meals][user.to_sym]  += 1 if record.meals
      stat[:diapers][user.to_sym]  += 1 if record.diapers
      if record.bottle
       if  record.bottle== 1
        stat[:bottles_full][user.to_sym] += 1
       else
        stat[:bottles_half][user.to_sym] += 1
       end
      end
    end
    stat
  end

  def self.perform_query_vaccine(child_id)
    child_states= where(:child_profile_id=>child_id).where("vaccine_id IS NOT NULL").where(:created_at => time_range).all
    list=[]
    vac = Hash.new
    child_states.each do |stat|
      vaccine=Vaccine.find_by_id(stat.vaccine_id)
      vac = {"vaccine"=>vaccine.title,"time"=>stat.created_at,"name"=>stat.parent_profile.name}
      list << vac
    end
    []
  end

  def self.get_child_vaccine(child_id,parent_id,type=nil)
      case type
        when "daily"
          time_range = 1.days.ago..Time.now
          perform_query_vaccine(child_id)
        when "weekly"
          time_range = 1.weeks.ago..Time.now
          perform_query_vaccine(child_id)
        when "monthly"
          time_range = 1.months.ago..Time.now
          perform_query_vaccine(child_id)
        when "yearly"
          time_range = 1.years.ago..Time.now
          perform_query_vaccine(child_id)
        else
          []
        end
    end

  def self.meals_query(child_id)
    time_range = 1.days.ago..Time.now
    child_states= where(:child_profile_id=>child_id).where("meals NOT NULL").where(:created_at => time_range).all
    list=[]
    meal = Hash.new
    child_states.each do |stat|
      meal = {"meal"=>stat.meals,"time"=>stat.created_at,"name"=>stat.parent_profile.name}
      list << meal
    end
    list
  end

  def self.get_child_meals(child_id,parent_id,type=nil)
    case type
      when "daily"
        time_range = 1.days.ago..Time.now
        meals_query(child_id)
      when "weekly"
        time_range = 1.weeks.ago..Time.now
        meals_query(child_id)
      when "monthly"
        time_range = 1.months.ago..Time.now
        meals_query(child_id)
      when "yearly"
        time_range = 1.years.ago..Time.now
        meals_query(child_id)
      else
        []
    end
  end

  def self.perform_diaper_query(child_id)
    child_states= where(:child_profile_id=>child_id).where("diapers IS NOT NULL").where(:created_at => time_range).all
    list=[]
    diaper = Hash.new
    child_states.each do |stat|
      diaper = {"time"=>stat.created_at,"name"=>stat.parent_profile.name}
      list << diaper
    end
    list
  end

  def self.get_child_diapers(child_id,parent_id,type=nil)
    case type
      when "daily"
        time_range = 1.days.ago..Time.now
        perform_diaper_query(child_id)
      when "weekly"
        time_range = 1.weeks.ago..Time.now
        perform_diaper_query(child_id)
      when "monthly"
        time_range = 1.months.ago..Time.now
        perform_diaper_query(child_id)
      when "yearly"
        time_range = 1.years.ago..Time.now
        perform_diaper_query(child_id)
      else
        []
    end
  end

  def self.perform_bottle_query(child_id,time_range, bottle)
    child_states= where(:child_profile_id=>child_id).where("bottle IS NOT NULL").where( :bottle=> bottle).where(:created_at => time_range).all
    half_bottle = Hash.new{|hash, key| hash[key] = Array.new;}
    child_states.each do |stat|
      time = stat.created_at.strftime("%m/%d/%Y")
      half_bottle[time] << stat.parent_profile.name
    end
    half_bottle
  end

  def self.get_child_bottle(child_id,parent_id,type=nil,bottle)
    case type
      when "daily"
        time_range = (1.days.ago..Time.now)
        perform_bottle_query(child_id, time_range, bottle)
      when "weekly"
        time_range = (1.weeks.ago..Time.now)
        perform_bottle_query(child_id, time_range, bottle)
      when "monthly"
        time_range = 1.months.ago..Time.now
        perform_bottle_query(child_id, time_range, bottle)
      when "yearly"
        time_range = (1.years.ago..Time.now)
        perform_bottle_query(child_id, time_range, bottle)
      else
        {}
    end
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
