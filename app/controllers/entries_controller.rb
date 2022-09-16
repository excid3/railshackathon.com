class EntriesController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy ]
  before_action :set_entry, only: %i[ edit update destroy ]
  before_action :ensure_only_one_entry, only: %i[ new create ]

  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to entries_path
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = current_user.team.build_entry(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @entry.destroy
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :website_url, :github_url, :description, :built_with, :complete, screenshots: [])
  end

  def set_entry
    @entry = current_user.team.entry
    redirect_to entries_path, alert: "Please create an entry first." unless @entry
  end

  def ensure_only_one_entry
    redirect_to entry_path(current_user.team.entry) if current_user.team.entry
  end
end
