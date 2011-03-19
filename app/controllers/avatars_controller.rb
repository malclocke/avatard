class AvatarsController < ApplicationController
  def index
    @avatars = Avatar.all
    @avatar = Avatar.new
  end

  def show
    #puts y request
    begin
      @avatar = Avatar.find_by_checksum!(params[:id])

      if params[:s]
        s = params[:s].to_i.to_s
      else
        s = Avatar::DEFAULT_SIZE
      end
      size = "#{s}x#{s}"

      respond_to do |format|
        format.png  { redirect_to @avatar.avatar.thumb(size).url }
        format.html
      end
    rescue ActiveRecord::RecordNotFound
      # FIXME - Need to find the right way to do this, cannot access
      # the URL helpers from controller
      redirect_to "http://#{request.host_with_port}/images/default.png"
    end
  end

  def create
    @avatar = Avatar.new params[:avatar]
    if @avatar.save
      redirect_to avatars_url
    else
      @avatars = Avatar.all
      render :index
    end
  end

  def update
    @avatar = Avatar.find_by_checksum!(params[:id])

    if @avatar.email == params[:avatar][:email]
      if @avatar.update_attributes params[:avatar]
        redirect_to avatars_url
      else
        render 'show'
      end
    else
      @avatar.errors.add(:email, 'address no matchy')
      render 'show'
    end
  end
end
