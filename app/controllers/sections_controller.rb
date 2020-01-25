class SectionsController < ApplicationController

  layout 'admin'
  
  before_action :find_current_page
  before_action :confirm_logged_in
  before_action :set_section_count, only: [:new, :create, :edit, :update]

  def index
    @sections = @page.sections.sorted
  end

  def new
    @section = Section.new
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    @section.page = @page
    if @section.save
      flash[:notice] = "Your section has been saved"
      redirect_to sections_path(page_id: @page.id)
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
      redirect_to section_path(@section, page_id: @page.id)
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
    redirect_to sections_path(page_id: @page.id)
    flash[:notice] = "Your section, #{@section.name}, has been deleted"
  end

  private

  def find_current_page
    @page = Page.find(params[:page_id])
  end

  def set_section_count
    @section_count = @page.sections.count
    if params[:action] == 'new' || params[:action] == 'create'
      @section_count += 1
    end
  end

  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content)
  end
end
