class SubjectsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
    @subject_count = Subject.count + 1 
  end

  def create
    # Instantiate the object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully!"
      redirect_to(:action => 'index')
    else
      # If save fails, redirect the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count # Count how many subjects we have
  end

  def update
    # Find an exisiting object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If Update succeeds, redirect to the show action
      flash[:notice] = "Subject update successfully!"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # If update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count # need to set all the instance variables used in the edit template/view
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private
  
    def subject_params
      # Same as using "params[:subject]", except that it:
      # - raises as error if :subject is not present
      # - allows listed attribuites to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end
end
