class Api::V1::MachinesController < Api::V1::BaseController
  before_filter :find_machine, :only => [:show, :update, :destroy]

  #require "digest"
  #auth_code = Digest::MD5.hexdigest("techno$garden")
  def show
    if "5e7add11cb09a9e70061776727555f4c" == params[:authcode]
      render action: :show  unless @machine
    else
      render json:{:status => false, :message=> "authcode not matched"}
    end
  end

  def update
    if params[:color].nil?
      render json:{:status => false, :message=> "provide color as parameter to update "}
      return
    end
    if "5e7add11cb09a9e70061776727555f4c" == params[:authcode]
      render action: :show   if  @machine.update_attributes(:color => params[:color])
    else
      render json:{:status => false, :message=> "authcode not matched "}
    end
  end

  def create
    params[:machine] = (params[:machine]).merge(:status => false)
    @machine = Machine.create(params[:machine])
    if @machine.valid?
      render json:{:status => true }
    else
      render json:{:status => false, :message => @machine.errors.full_messages }
    end
  end

  def destroy
    if @machine.update_attributes(:status => false)
      render json:{:status => true}
    else
      render json:{:status => false, :message => @machine.errors.full_messages }
    end
  end

  private
  def find_machine
    begin
      @machine = Machine.find_by_serialid(params[:serialid])
      raise  ActiveRecord::RecordNotFound if @machine.nil?
    rescue ActiveRecord::RecordNotFound  => exception
      render json:{:status => false, :message => exception.message}
    end
  end


end