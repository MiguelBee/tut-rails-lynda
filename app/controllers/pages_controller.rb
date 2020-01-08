class PagesController < ApplicationController
  
  layout 'admin'
  
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page_count = Page.count + 1
    @subjects = Subject.sorted
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "You have successfully created a Page"
      redirect_to pages_path
    else
      @page_count = Page.count + 1
      @subjects = Subject.sorted
      render("new")
    end
  end

  def edit
    @page_count = Page.count
    @subjects = Subject.sorted
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Your page updated successfully"
      redirect_to page_path(@page)
    else
      @page_count = Page.count
      @subjects = Subject.sorted
      render("edit")
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page, #{@page.name}, has been deleted"
    redirect_to pages_path
  end

private

  def page_params
    params.require(:page).permit(:subject_id, :permalink, :name, :position, :visible)
  end
end
