class PagesController < ApplicationController
  
  layout 'admin'
  
  before_action :find_current_subject
  before_action :confirm_logged_in
  before_action :set_page_count, only: [:new, :create, :edit, :update]

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(subject_id: @subject.id)
  end

  def create
    @page = Page.new(page_params)
    @page.subject = @subject
    if @page.save
      flash[:notice] = "You have successfully created a Page"
      redirect_to pages_path(subject_id: @subject.id)
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
      redirect_to page_path(@page, subject_id: @subject.id)
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
    redirect_to pages_path(subject_id: @subject.id)
  end

private

  def find_current_subject
    @subject = Subject.find(params[:subject_id])
  end

  def set_page_count
    @page_count = @subject.pages.count
    if params[:action] == 'new' || params[:actoin] == 'create'
      @page_count += 1
    end
  end

  def page_params
    params.require(:page).permit(:permalink, :name, :position, :visible)
  end
end
