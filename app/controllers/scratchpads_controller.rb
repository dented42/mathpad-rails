class ScratchpadsController < ApplicationController
  before_action :set_scratchpad, only: [:show, :edit, :update, :destroy]

  # GET /scratchpads
  # GET /scratchpads.json
  def index
    @scratchpads = Scratchpad.all
  end

  # GET /users/:user_id/scratchpads
  # GET /user/:user_id/scratchpads.json
  def user_index
    @user = User.find(params[:user_id])
    @can_edit = current_user? @user
    @scratchpads = @user.scratchpads.all
  end

  # GET /scratchpads/1
  # GET /scratchpads/1.json
  def show
    respond_to do | format |
      format.html do
        @can_edit = current_user? @scratchpad.user
        @scratchpad_props = render_to_string json: @scratchpad,
          meta: {
            editable: current_user?(@scratchpad.user),
            maximum_sync_connections: 1,
            sync: { push: true, pull: false } # pull not implemented yet
          }
      end
      format.json { render json: @scratchpad }
    end
  end

  # GET /scratchpads/new
  def new
    authenticate_user!
    @scratchpad = Scratchpad.new
    @scratchpad.user = current_user
  end

  # GET /scratchpads/1/edit
  def edit
    authenticate_user!
    @lines_as_text = @scratchpad.lines.join("\n")
  end

  # POST /scratchpads
  # POST /scratchpads.json
  def create
    authenticate_user!
    @scratchpad = Scratchpad.new(scratchpad_params)

    respond_to do |format|
      if @scratchpad.save
        format.html { redirect_to @scratchpad, notice: 'Scratchpad was successfully created.' }
        format.json { render :show, status: :created, location: @scratchpad }
      else
        format.html { render :new }
        format.json { render json: @scratchpad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scratchpads/1
  # PATCH/PUT /scratchpads/1.json
  def update
    authenticate_user!
    respond_to do |format|
      pars = scratchpad_params
      pars["lines"] = pars["lines"].split(/(\r|\n)+/).delete_if do |line| 
        line.match(/^[[:space:]]*$/)
      end
      if @scratchpad.update(pars)
        format.html { redirect_to @scratchpad, notice: 'Scratchpad was successfully updated.' }
        format.json { render :show, status: :ok, location: @scratchpad }
      else
        format.html { render :edit }
        format.json { render json: @scratchpad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scratchpads/1
  # DELETE /scratchpads/1.json
  def destroy
    authenticate_user!
    if current_user?(@scratchpad.user)
      @scratchpad.destroy
      respond_to do |format|
        format.html { redirect_to scratchpads_url, notice: 'Scratchpad was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scratchpad
      @scratchpad = Scratchpad.find(params[:id])
    end

    def current_user?(user)
      if user_signed_in? then
        current_user.id == user.id
      else
        false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scratchpad_params
      params.require(:scratchpad).permit(:title, :description, :user_id, :lines)
    end
end
