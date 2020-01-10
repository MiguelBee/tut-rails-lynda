class SectionsController < ApplicationController

  layout 'admin'
  
  before_action :set_section_count, only: [:new, :create, :edit, :update]
  before_action :find_pages, only: [:new, :create, :edit, :update]

  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Your section has been saved"
      redirect_to sections_path
    else
      render("new")
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Your section has been updated"
      redirect_to section_path(@section)
    else
      render("edit")
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_path
    flash[:notice] = "Your section, #{@section.name}, has been deleted"
  end

  private

  def set_section_count
    @section_count = Section.count
    if params[:action] == 'new' || params[:action] == 'create'
      @section_count += 1
    end
  end

  def find_pages
    @pages = Page.sorted
  end

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
