class PagesController < ApplicationController
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new 
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "You have successfully created a Page"
      redirect_to pages_path
    else
      render("new")
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Your page updated successfully"
      redirect_to page_path(@page)
    else
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
