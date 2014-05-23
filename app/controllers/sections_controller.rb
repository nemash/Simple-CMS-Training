class SectionsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_page

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id, :name => 'Default'})
    @pages = @page.subject.pages.sorted
    @section_count = Section.count + 1
  end

  def create
    # Instantiate a new object using form paramters
    @section = Section.new(section_params)
    # Save the object
    if @section.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Section created sucessfully"
      redirect_to(:action => 'index', :page_id => @page.id)
    else
      # If save fails, redisplay tne form so the user can fix the problem
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render('index')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    # Find an existing object using form parameters
    @section = Section.find(params[:id])
    # Update the object
    if @section.update_attributes(section_params)
      # If update succeeds, redirect to the show
      flash[:notice] = "Section updated sucessfully"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      # If update fails, redisplays the form so user can fix problems
      @pages = Page.order('position ASC')
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully"
    redirect_to(:action => 'index', :page_id => @page.id)
  end

  private
    
    def section_params
      # Same as using "params[:section]" except that
      # - raises an error if :section is not present
      # - allows listed attributes to be mass assigned
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
    end
end
