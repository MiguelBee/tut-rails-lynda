class SectionsController < ApplicationController

  layout 'admin'
  
  def index
    @sections = Section.all
  end

  def new
    @section_count = Section.count + 1
    @pages = Page.sorted
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
      @section_count = Section.count + 1
      @pages = Page.sorted
      render("new")
    end
  end

  def edit
    @section_count = Section.count
    @pages = Page.sorted
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Your section has been updated"
      redirect_to section_path(@section)
    else
      @section_count = Section.count
      @pages = Page.sorted
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

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
